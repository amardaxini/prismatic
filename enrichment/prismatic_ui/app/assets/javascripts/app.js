var PR = PR || {};
PR = (function($, window, document, Prismatic){
  PR.app ={
    validateForm : function(){
      $(".validate_form").validate({ignore: 'input[type=hidden]'});
    },
    initWysihtml5 :function(){
      $(".wysihtml5").wysihtml5({
        image: false,
      })
    },
    dropdown : function(){
      $("select.dropdown").select2()
    },

    multiple_select : function(){
      $("select.multiple_select").select2()
    },
    initDatePicker : function(){
      $('.date-picker').datepicker({
          format: 'yyyy-mm-dd',
      });
    }
   
  };
 return Prismatic;
 
})(jQuery, this, this.document, PR);