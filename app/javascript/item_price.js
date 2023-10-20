const priceInput = document.getElementById("item-price");
const addTaxDom = document.getElementById("add-tax-price");
const ProfitDom = document.getElementById("profit");

priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;
  addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
  ProfitDom.innerHTML = inputValue - addTaxDom.innerHTML;
});

document.addEventListener('turbo:frame-load', (event) => {
  if (event.target.id === 'item-price') {
    priceInput.dispatchEvent(new Event('input'));
  }
});
