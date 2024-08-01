function keyPressed(title, dueDate, event) {
  if (event.keyCode == 13) {
    addTask(title, dueDate);
  }
}

function addTask(title, dueDate) {
  if (title !== '') {
    if (dueDate === '') {
      let date = new Date();
      dueDate = date.toLocaleDateString();
    }

    let task = {
      title: title,
      date: dueDate
    }

    for (let index = 0; index < document.getElementById('taskTBody').children.length; index++) {
      if (document.getElementById('taskTBody').children[index].id === title) {
        task.title = `${task.title} (copy)`;
      }
    }

    insertTask(task);
    document.getElementById('floatingInputGroup').value = '';
  } else {
    document.getElementsByClassName('invalid-feedback')[0].innerHTML = "Sorry, you have to enter a title."
  }
}

function insertTask(task) {
  let circle = createCircle(task);
  let title = createTitle(task.title);
  let date = createDueDate(task.date);

  let tr = document.createElement('tr');
  tr.id = task.title;
  tr.append(circle, title, date);

  document.getElementById('taskTable').classList.remove('visually-hidden');
  document.getElementById('taskTBody').appendChild(tr);
}

function completeTask(title) {
  if (document.getElementById(title).firstChild.firstChild.classList.contains('fa-regular')) {
    document.getElementById(title).firstChild.firstChild.classList.replace('fa-circle-check', 'fa-circle-xmark');
  }

  document.getElementById(title).style.animation = 'fadeIn 5s';

  setTimeout(() => {
    document.getElementById(title).remove();
  }, 5000);
}

function createCircle(task) {
  let icon = document.createElement('i');
  icon.classList.add('fa-regular', 'fa-circle');
  icon.role = 'button';
  icon.onmouseover = function () {
    this.classList.replace('fa-circle', 'fa-circle-check');
  }
  icon.onmouseout = function () {
    this.classList.replace('fa-circle-check', 'fa-circle');
  }
  icon.onclick = function () {
    completeTask(task.title);
  }

  let td = document.createElement('td');
  td.appendChild(icon);

  return td;
}

function createTitle(title) {
  let td = document.createElement('td');
  td.id = 'title';
  td.innerHTML = title;

  return td;
}

function createDueDate(date) {
  let td = document.createElement('td');
  td.id = 'dueDate';
  td.innerHTML = date;

  return td;
}