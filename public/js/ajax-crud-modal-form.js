
function doResponseCommand(data){
    if(data.reload)
        window.location.href = window.location.href;
    else if(typeof data.redirect_url != 'undefined')
        ajaxLoad(data.redirect_url);
    else if(typeof data.table_refresh != 'undefined')
        $('#' + data.table_refresh).DataTable().ajax.reload();
}

$(document).on('click', 'a.page-link', function (event) {
    event.preventDefault();
    ajaxLoad($(this).attr('href'));
});
$(document).on('submit', '#modalForm form#frmTbl', function (event) {
    event.preventDefault();
    var form = $(this);
    var data = new FormData(form[0]);
    var url = form.attr("action");
    $.ajax({
        type: form.attr('method'),
        url: url,
        data: data,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data) {
            $('.has-error').removeClass('has-error');
            $('.help-block').remove();
            if (data.fail) {
                for (control in data.errors) {
                    $('[name=' + control + ']').parent().addClass('has-error');
                    $('[name=' + control + ']').parent().append('<span class="help-block" style="color:#f96868">' + data.errors[control] + '</span>');
                }
            } else {
                $('#modalForm').modal('hide');
                doResponseCommand(data);
                if (typeof onPostSubmitPopup === "function")
                    onPostSubmitPopup();
            }
        },
        error: function (xhr, textStatus, errorThrown) {
            alert("Error: " + errorThrown);
        }
    });
    return false;
});
function ajaxLoad(filename, content) {
    content = typeof content !== 'undefined' ? content : 'content';
    $('.loading').show();
    $.ajax({
        type: "GET",
        url: filename,
        contentType: false,
        success: function (data) {
            $("#" + content).html(data);
            $('.loading').hide();
            if (typeof onPostLoadPopup === "function")
                onPostLoadPopup();
        },
        error: function (xhr, status, error) {
            alert(xhr.responseText);
        }
    });
}
function ajaxDelete(filename, token, content) {
    content = typeof content !== 'undefined' ? content : 'content';
    $('.loading').show();
    $.ajax({
        type: 'POST',
        data: {_method: 'DELETE', _token: token},
        url: filename,
        success: function (data) {
            $('#modalDelete').modal("hide");
            $("#" + content).html(data);
            $('.loading').hide();
            doResponseCommand(data);
            if (typeof onPostDeleteDetalle === "function")
                onPostDeleteDetalle();
        },
        error: function (xhr, status, error) {
            alert(xhr.responseText);
        }
    });
}

$('#modalForm').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    ajaxLoad(button.data('href'), 'modal_content');
});
$('#modalForm').on('shown.bs.modal', function () {
    $('#focus').trigger('focus');
});

$('#modalDelete').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    $('#delete_id').val(button.data('id'));
    $('#delete_token').val(button.data('token'));
    $('#delete_nombre').html(button.data('nrolinea') + '<br/>' + button.data('nombre'));
});
