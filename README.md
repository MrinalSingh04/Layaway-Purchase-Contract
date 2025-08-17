# 🛍️ Layaway Purchase Contract

### 📌 What

The **Layaway Purchase Contract** allows customers to buy products in **installments**.

- The buyer pays the product price over time in small payments (installments).  
- The funds are **locked in the smart contract** until the **total price is reached**. 
- Once the target is met, the seller receives the full amount automatically.
- If the buyer cannot complete payments before the deadline, they can **claim a refund**.    

This mimics the concept of **layaway plans or EMIs**, but in a **trustless, blockchain-powered way**.

---

### 💡 Why

Traditional installment/layaway systems depend on **trusted intermediaries** (shops, banks, or fintechs). Problems include:

- ❌ Seller misusing buyer’s partial payments.
- ❌ Buyer losing money if seller defaults.
- ❌ No transparency in how/when payments are recorded.

By using this smart contract:

- ✅ Buyer’s money is **secure until the purchase is fully paid**.
- ✅ Seller only receives funds if **target is reached**.
- ✅ If not completed on time, buyer can **withdraw their funds back**.
- ✅ All transactions are **on-chain, transparent, and immutable**.

---

### ⚙️ Features

- Pay in multiple installments.
- Automatic full payment to seller once total price is met.
- Refund option for buyer if deadline passes without completion.
- Publicly verifiable payments and balances.

---

### 🛠️ How to Use

1. **Deploy contract** with:

   - `buyer` address
   - `totalPrice` (in wei)
   - `durationInDays` (deadline to complete payment)

2. **Buyer pays installments** via `payInstallment()` until reaching `totalPrice`.

3. If **target is reached before deadline**, seller gets funds.

4. If **deadline passes without full payment**, buyer calls `refund()` to withdraw.

---

### 🔒 Example Use Case

- A seller lists a laptop worth **2 ETH**.
- Buyer commits to purchase via this contract.
- Buyer pays **0.5 ETH weekly** for 4 weeks.
- After full 2 ETH is paid → contract releases payment to seller.
- If buyer only pays 1 ETH by deadline → buyer gets refund of 1 ETH.

---

✅ This makes installment purchases **fair, trustless, and transparent**.
