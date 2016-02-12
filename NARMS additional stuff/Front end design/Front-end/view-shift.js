(function ($) {
    $(onDomReady());

    function onDomReady() {
        console.log('ready');
    }

    var showFormBtn = $('#show-form-btn');
    var hideFormBtn = $('#hide-form-btn');
    var facilitySelect = $('#facility-select');
    var atcoSelect = $('#atco-select');
    var addAtcoBtn = $('#add-atco');
    var addAtcoForm = $('#add-atco-form');

    $(addAtcoForm).hide();

    $(showFormBtn).on('click', function (e) {
        console.log('show');
        $(addAtcoForm).show();
        $(showFormBtn).hide();
    });

    $(hideFormBtn).on('click submit', function (e) {
        e.preventDefault();
        console.log('hide');
        $(addAtcoForm).hide();
        $(showFormBtn).show();
        return false;
    });

    $(addAtcoBtn).on('click submit', function (e) {
        e.preventDefault();
        console.log('submit');
        return false;
    });

    // event delegation
    $('.container button.close').on('click', function (e) {
        console.log('Remove atco');
    });

})(jQuery);