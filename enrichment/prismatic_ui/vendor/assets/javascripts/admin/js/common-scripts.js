var IQ = IQ || {};
IQ = (function($, window, document, Internq){
  Internq.common ={
    iniLeftBar : function(){
      $('#nav-accordion').dcAccordion({
        eventType: 'click',
        autoClose: true,
        saveState: true,
        disableLink: true,
        speed: 'slow',
        showCount: false,
        autoExpand: true,
        //  cookie: 'dcjq-accordion-1',
        classExpand: 'dcjq-current-parent'
      });
    },
    initSidebarSubmenuScroll : function(){

      $('#sidebar .sub-menu > a').on("click",function (e){
        var o = ($(this).offset());
        diff = 250 - o.top;
        if(diff>0)
            $("#sidebar").scrollTo("-="+Math.abs(diff),500);
        else
            $("#sidebar").scrollTo("+="+Math.abs(diff),500);
      });
    },
    responsiveView : function(){
      var wSize = $(window).width();
      if (wSize <= 768) {
        $('#container').addClass('sidebar-close');
        $('#sidebar > ul').hide();
      }

      if (wSize > 768) {
          $('#container').removeClass('sidebar-close');
          $('#sidebar > ul').show();
      }
    },
    toggleSidebar : function(){
      $('.fa-bars').on("click",function (e) {
        if ($('#sidebar > ul').is(":visible") === true) {
          $('#main-content').css({
              'margin-left': '0px'
          });
          $('#sidebar').css({
              'margin-left': '-210px'
          });
          $('#sidebar > ul').hide();
          $("#container").addClass("sidebar-closed");
        } 
        else {
          $('#main-content').css({
              'margin-left': '210px'
          });
          $('#sidebar > ul').show();
          $('#sidebar').css({
              'margin-left': '0'
          });
          $("#container").removeClass("sidebar-closed");
        }
      });
    },
    initScrollbar : function(){
      $("#sidebar").niceScroll({styler:"fb",cursorcolor:"#e8403f", cursorwidth: '3', cursorborderradius: '10px', background: '#404040', spacebarenabled:false, cursorborder: ''});
      $("html").niceScroll({styler:"fb",cursorcolor:"#e8403f", cursorwidth: '6', cursorborderradius: '10px', background: '#404040', spacebarenabled:false,  cursorborder: '', zindex: '1000'});
    },
    initTooltip : function(){
      $('.tooltips').tooltip();
      $("[rel=tooltip]").tooltip()
    },
    initPopover : function(){
      $('.popovers').popover();
      $("[rel*=popover]").popover({offset:10,trigger:"hover",html:true});
    },
    initDatepicker : function() {
      $('.date-picker').datepicker({
          format: 'yyyy-mm-dd'
      });
    },
    initSlideBar : function(){
      $.slidebars();
    },
    validateForm : function(){
      $(".validate_form").validate({ignore: 'input[type=hidden]'});
    },
    html5Editor : function(){
      $(".wysihtml5").wysihtml5({
        image: false,
      })
    },
    dropdown : function(){
      $("select.dropdown").select2()
    },
  };
  $(window).on('load', Internq.common.responsiveView);
  $(window).on('resize', Internq.common.responsiveView);
  return Internq;
 
})(jQuery, this, this.document, IQ);

$(document).ready(function(){
    IQ.common.iniLeftBar();
    IQ.common.initSidebarSubmenuScroll();
    IQ.common.toggleSidebar();
    IQ.common.initScrollbar();
    IQ.common.initTooltip();
    IQ.common.initPopover();
    IQ.common.initDatepicker();
    IQ.common.initSlideBar();
    IQ.common.validateForm()
  })
/*---LEFT BAR ACCORDION----*/
// $(function() {
//     $('#nav-accordion').dcAccordion({
//         eventType: 'click',
//         autoClose: true,
//         saveState: true,
//         disableLink: true,
//         speed: 'slow',
//         showCount: false,
//         autoExpand: true,
// //        cookie: 'dcjq-accordion-1',
//         classExpand: 'dcjq-current-parent'
//     });
// });

// // right slidebar
// $(function(){
//  $.slidebars();
// });

// var Script = function () {

// //    sidebar dropdown menu auto scrolling

//     jQuery('#sidebar .sub-menu > a').click(function () {
//         var o = ($(this).offset());
//         diff = 250 - o.top;
//         if(diff>0)
//             $("#sidebar").scrollTo("-="+Math.abs(diff),500);
//         else
//             $("#sidebar").scrollTo("+="+Math.abs(diff),500);
//     });

// //    sidebar toggle

//     $(function() {
//         function responsiveView() {
//             var wSize = $(window).width();
//             if (wSize <= 768) {
//                 $('#container').addClass('sidebar-close');
//                 $('#sidebar > ul').hide();
//             }

//             if (wSize > 768) {
//                 $('#container').removeClass('sidebar-close');
//                 $('#sidebar > ul').show();
//             }
//         }
//         $(window).on('load', responsiveView);
//         $(window).on('resize', responsiveView);
//     });

//     $('.fa-bars').click(function () {
//         if ($('#sidebar > ul').is(":visible") === true) {
//             $('#main-content').css({
//                 'margin-left': '0px'
//             });
//             $('#sidebar').css({
//                 'margin-left': '-210px'
//             });
//             $('#sidebar > ul').hide();
//             $("#container").addClass("sidebar-closed");
//         } else {
//             $('#main-content').css({
//                 'margin-left': '210px'
//             });
//             $('#sidebar > ul').show();
//             $('#sidebar').css({
//                 'margin-left': '0'
//             });
//             $("#container").removeClass("sidebar-closed");
//         }
//     });

// // custom scrollbar
//     $("#sidebar").niceScroll({styler:"fb",cursorcolor:"#e8403f", cursorwidth: '3', cursorborderradius: '10px', background: '#404040', spacebarenabled:false, cursorborder: ''});

//     $("html").niceScroll({styler:"fb",cursorcolor:"#e8403f", cursorwidth: '6', cursorborderradius: '10px', background: '#404040', spacebarenabled:false,  cursorborder: '', zindex: '1000'});

// // widget tools

//     jQuery('.panel .tools .fa-chevron-down').click(function () {
//         var el = jQuery(this).parents(".panel").children(".panel-body");
//         if (jQuery(this).hasClass("fa-chevron-down")) {
//             jQuery(this).removeClass("fa-chevron-down").addClass("fa-chevron-up");
//             el.slideUp(200);
//         } else {
//             jQuery(this).removeClass("fa-chevron-up").addClass("fa-chevron-down");
//             el.slideDown(200);
//         }
//     });

//     jQuery('.panel .tools .fa-times').click(function () {
//         jQuery(this).parents(".panel").parent().remove();
//     });


// //    tool tips

//     $('.tooltips').tooltip();

// //    popovers

//     $('.popovers').popover();



// // custom bar chart

//     if ($(".custom-bar-chart")) {
//         $(".bar").each(function () {
//             var i = $(this).find(".value").html();
//             $(this).find(".value").html("");
//             $(this).find(".value").animate({
//                 height: i
//             }, 2000)
//         })
//     }



   


// }();