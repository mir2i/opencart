<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-google-base" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">

      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-google-base" class="form-horizontal">
            <ul class="nav nav-tabs">
            		<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            		<li><a href="#tab-ip" data-toggle="tab"><?php echo $tab_ip; ?></a></li>
                  </ul>          <div class="tab-content">
                              <div class="tab-pane active" id="tab-general"> <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status"><span data-toggle="tooltip" title="<?php echo $help_order_status; ?>"><?php echo $entry_order_status; ?></span></label>
            <div class="col-sm-10">
              <select name="ip_order_status_id" id="input-order-status" class="form-control">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $ip_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="ip_status" id="input-status" class="form-control">
                <?php if ($ip_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
      </div>
      <div class="tab-pane" id="tab-ip">
          <fieldset>
              <legend><?php echo $text_ip_add; ?></legend>
              <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-ip"><?php echo $entry_ip; ?></label>
                  <div class="col-sm-10">
                          <input type="text" value="" placeholder="<?php echo $entry_ip; ?>" id="input-ip" class="form-control" />
                          <span class="input-group-btn">
                              <button type="button" id="button-ip-add" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_ip_add; ?></button>
                          </span>
                      </div>
                  </div>
              </div>



            </fieldset>
            <br />
            <fieldset>
              <legend><?php echo $text_ip_list; ?></legend>

            <div id="ip"></div>
        </fieldset>
          </div></div>

      
      </form>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#ip').delegate('.pagination a', 'click', function(e) {
	e.preventDefault();

	$('#ip').load(this.href);
});

$('#ip').load('index.php?route=fraud/ip/ip&token=<?php echo $token; ?>');

$('#button-ip-add').on('click', function() {
	$.ajax({
		url: 'index.php?route=fraud/ip/addip&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		data: 'ip=' + encodeURIComponent($('#input-ip').val()),
		beforeSend: function() {
			$('#button-ip-add').button('loading');
		},
		complete: function() {
			$('#button-ip-add').button('reset');
		},
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				 $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}

			if (json['success']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                $('#ip').load('index.php?route=fraud/ip/ip&token=<?php echo $token; ?>');

                $('#input-ip').val('');
            }
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});

$('#ip').delegate('button', 'click', function() {
	var element = this;

	$.ajax({
		url: 'index.php?route=fraud/ip/removeip&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		data: 'ip=' + encodeURIComponent($(element).val()),
		beforeSend: function() {
			$(element).button('loading');
		},
		complete: function() {
			$(element).button('reset');
		},
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				 $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}

			if (json['success']) {
				 $('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                 $('#ip').load('index.php?route=fraud/ip/ip&token=<?php echo $token; ?>');
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});
//--></script></div>
<?php echo $footer; ?>
