<?php echo $header; ?>
<script language="javascript">
$(document).ready(function(e) {
    $("#message").keypress(function(){		
		var len = $("#message").val().length;	
		len  = len + 1
		$('#charNum').html(len);	
	})
});	
</script>

<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div style="width:100%">
    <div class="box" style="width:73%;float:left">
      <div class="heading">
        <h1><img src="view/image/category.png" alt="" /> <?php echo $heading_title; ?></h1>
        <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
      </div>
      <div class="content">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
          <table class="form">
            <tr style="display:none">
              <td><span class="required">*</span><?php echo $entry_sms_type; ?></td>
              <td><select id="sms_type" name="sms_type">
                  <option value="customer" <?php echo $sms_type=='customer'?' selected="selected"':''; ?> >Customer</option>
                </select>
                <?php if ($error_sms_type) { ?>
                <span class="error"><?php echo $error_sms_type; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span><?php echo $entry_subject; ?></td>
              <td><input type="text" name="subject" size="83" value="<?php echo $subject; ?>" />
                <?php if ($error_subject) { ?>
                <span class="error"><?php echo $error_subject; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span><?php echo $entry_message; ?></td>
              <td><textarea id="message" name="message" cols="80" rows="5"><?php echo isset($message) ? $message : ''; ?></textarea>
                <table width="100%">
                  <tr>
                    <td>Count : <span id="charNum" style="color:#3366FF;font-size:15;font-weight:bold"><?php echo isset($message) ? (0) : ''; ?></span></td>
                    <td><a href="javascript://" id="import_sms_templates" class="button">Import</a></td>
                  </tr>
                </table>
                <?php if ($error_message) { ?>
                <span class="error"><?php echo $error_message; ?></span>
                <?php } ?>
                <div id="file_list" style="display:none">sdfsfsdfsd</div></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select id="status" name="status">
                  <?php if($status=='1'){ ?>
                  <option value="1" selected="selected">Enabled</option>
                  <?php }else{ ?>
                  <option value="1">Enabled</option>
                  <?php } ?>
                  <?php if($status=='0'){ ?>
                  <option value="0" selected="selected">Disabled</option>
                  <?php } else { ?>
                  <option value="0">Disabled</option>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        </form>
      </div>
    </div>
    <div class="box" style="width:25%;float:right">
      <div class="heading">
        <h1><img src="view/image/category.png" alt="" />Tag</h1>
      </div>
      <div class="content">
        <table class="form">
          <tr>
            <td colspan="2"><h3> <span>Tag List </span></h3></td>
          </tr>
          <tbody id="view_tagList">
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<style type="text/css">
.file_list_div{
	width:100%;
	max-height:auto;
	background:#D7EBF7;	
}
</style>
<script language="javascript">
// Get File Data 
function getFileContent(filename){
	$.ajax({
		type: "POST",		 
		data : { filename:filename },
		url: 'index.php?route=communication/template_sms/getFileData&token=<?php echo $this->session->data["token"]; ?>',			
		success: function(data,status){ 			
				$("#message").val(data);			 
		 },
		 error: function(e) {
		   console.log(e.message);
		}
	});
} 
$(document).ready(function(e) { 
	
	$("#sms_type").change(function(){		
		$.ajax({
		type: "POST",		 
		data : { sms_type:$("#sms_type").val()},
		url: 'index.php?route=communication/template_sms/getTagList&token=<?php echo $this->session->data["token"]; ?>',			
		success: function(data,status){ 			
				$("#view_tagList").html(data);			 
		 },
		 error: function(e) {
		   console.log(e.message);
	    }
	  });		
	}).trigger('change');
	
	// Get List of File in SMS Templates
    $("#import_sms_templates").click(function(){		
		$.ajax({
			type: "POST",
			url: 'index.php?route=communication/template_sms/getAllTemplates&token=<?php echo $this->session->data["token"]; ?>',			
			success: function(data,status){ 			
				 // Dispaly File List 
				 $("#file_list").show(500).addClass("file_list_div");
				 $("#file_list").html(data);
				 
				// Get File Name :: 			 
				 $(".file_name_val").click(function(event) {
					getFileContent(event.target.id);
				});
				
				//Close Button
				$("#div_close").click(function(){		
					$("#file_list").hide(1500).removeClass("file_list_div");
				});
				 
			 },
		     error: function(e) {
       		   console.log(e.message);
      		}
		});
	});	 
	
});

</script> 
<?php echo $footer; ?>