$(document).ready(function () {
    //Postal code
    $('.txtPostalCode').mask('A0S 0S0', {
        placeholder: '___ ___',
        translation: {
            A: { pattern: /[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]/ },
            S: { pattern: /[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvwxyz]/ }
        }
    });
    $('.txtPostalCode').keyup(function () {
        $(this).val($(this).val().toUpperCase());
    });

    //Phone number
    $('.txtPhoneNumber').mask('000-000-0000', { placeholder: '___-___-____' });

    const registrationForm = document.querySelectorAll('.needs-validation-register');
    addValidationToForm(registrationForm);
});

function addValidationToForm(forms) {
    Array.prototype.slice.call(forms)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                form.classList.add('was-validated')
            }, false)
        });
}