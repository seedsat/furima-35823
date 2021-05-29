function price() {
  const priceField = document.getElementById('item-price');
  priceField.addEventListener('keyup', () => {
    const price = priceField.value;
    /* 手数料表示の処理 */
    const taxField = document.getElementById('add-tax-price');
    const taxPrice = Math.trunc(price * 0.1);
    taxField.innerHTML = taxPrice;


    /* 利益表示の処理 */
    const profitField = document.getElementById('profit');
    const profit = price - taxPrice;
    profitField.innerHTML = profit;
  });
};

window.addEventListener('load', price)