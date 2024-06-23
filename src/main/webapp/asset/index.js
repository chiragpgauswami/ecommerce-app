const menuBtn = document.querySelector(".menu-icon span");
const searchBtn = document.querySelector(".search-icon");
const cancelBtn = document.querySelector(".cancel-icon");
const items = document.querySelector(".nav-items");
const form = document.querySelector("form");
menuBtn.onclick = () => {
	items.classList.add("active");
	menuBtn.classList.add("hide");
	searchBtn.classList.add("hide");
	cancelBtn.classList.add("show");
};
cancelBtn.onclick = () => {
	items.classList.remove("active");
	menuBtn.classList.remove("hide");
	searchBtn.classList.remove("hide");
	cancelBtn.classList.remove("show");
	form.classList.remove("active");
};


function increaseCount(a, b) {
		var input = b.previousElementSibling;
		var value = parseInt(input.value, 10);
		value = isNaN(value) ? 0 : value;
		value++;
		input.value = value;
	}
	function decreaseCount(a, b) {
		var input = b.nextElementSibling;
		var value = parseInt(input.value, 10);
		if (value > 1) {
			value = isNaN(value) ? 0 : value;
			value--;
			input.value = value;
		}
	}