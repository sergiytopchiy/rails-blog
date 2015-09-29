
$(document).on("mouseenter", ".article_body", function(){
    $(this).animate({left: "20px", height: '+=40px', width: '+=40px'}, "fast");
  });

$(document).on("mouseleave", ".article_body", function(){
    $(this).animate({right: "20px", height: '-=40px', width: '-=40px'}, "fast");
  });
