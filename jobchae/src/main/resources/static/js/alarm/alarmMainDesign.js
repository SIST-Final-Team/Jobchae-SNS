document.addEventListener("click", (e) => {

    if(e.target.className == "alarmDropdown"){
        return;
    }

    const alarmDropdown = document.querySelectorAll('details[open]');

    alarmDropdown.forEach(item =>{
       item.removeAttribute('open');
    });
});