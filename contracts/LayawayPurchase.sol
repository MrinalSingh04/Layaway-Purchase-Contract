// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

/**
 * Funds are only released to the seller when the target amount is reached.
 * If deadline passes and full amount is not paid, customer can claim refund.
 */
contract LayawayPurchase {
    address public seller;
    address public buyer;
    uint256 public totalPrice;
    uint256 public deadline;
    uint256 public amountPaid;
    bool public isCompleted;

    mapping(address => uint256) public contributions;

    event InstallmentPaid(
        address indexed buyer,
        uint256 amount,
        uint256 totalPaid
    );
    event PurchaseCompleted(address indexed seller, uint256 totalAmount);
    event Refunded(address indexed buyer, uint256 amount);

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this");
        _;
    }

    modifier beforeDeadline() {
        require(block.timestamp <= deadline, "Past deadline");
        _;
    }

    constructor(address _buyer, uint256 _totalPrice, uint256 _durationInDays) {
        require(_buyer != address(0), "Invalid buyer");
        require(_totalPrice > 0, "Price must be greater than zero");

        seller = msg.sender;
        buyer = _buyer;
        totalPrice = _totalPrice;
        deadline = block.timestamp + (_durationInDays * 1 days);
    }

    /// @notice Pay installment towards the purchase
    function payInstallment() external payable onlyBuyer beforeDeadline {
        require(!isCompleted, "Already completed");
        require(msg.value > 0, "Must pay something");

        amountPaid += msg.value;
        contributions[msg.sender] += msg.value;

        emit InstallmentPaid(msg.sender, msg.value, amountPaid);

        if (amountPaid >= totalPrice) {
            isCompleted = true;
            payable(seller).transfer(amountPaid);
            emit PurchaseCompleted(seller, amountPaid);
        }
    }

    /// @notice Refund buyer if target not met by deadline
    function refund() external onlyBuyer {
        require(block.timestamp > deadline, "Deadline not reached yet");
        require(!isCompleted, "Purchase already completed");
        uint256 paid = contributions[buyer];
        require(paid > 0, "No funds to refund");

        contributions[buyer] = 0;
        payable(buyer).transfer(paid);

        emit Refunded(buyer, paid);
    }

    /// @notice Get contract summary
    function getSummary()
        external
        view
        returns (
            address _seller,
            address _buyer,
            uint256 _totalPrice,
            uint256 _amountPaid,
            uint256 _deadline,
            bool _isCompleted
        )
    {
        return (seller, buyer, totalPrice, amountPaid, deadline, isCompleted);
    }
}
