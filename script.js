document.addEventListener("DOMContentLoaded", () => {
  // Select all cards and arrows
  const elements = document.querySelectorAll(".card, .arrow");

  // Animate them one by one with a delay
  elements.forEach((el, index) => {
    setTimeout(() => {
      el.style.animation = "fadeIn 0.6s ease-out forwards";
    }, index * 400); // 400ms delay between each item
  });

  console.log("Terraform Automation Dashboard Loaded.");
});
