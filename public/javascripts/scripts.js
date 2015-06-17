$(document).ready(function() {

    $(function() {
      $(".draggable").draggable({helper: 'clone'});
    });

    function rechange_user_bg(el) {
        el.css('background-image', 'url("/images/style/user_bg.jpg")');
    }
    function rechange_freeitems_bg(el) {
        el.css('background-image', 'url("/images/style/aufgaben_bg.jpg")');
    }

    // USER (Targets)
    $(".user").droppable({
        //hoverClass: "draghovered",

        over: function(ev, ui){            
            $(this).css('background-image', 'url("/images/icons/drop_bg.png")');
        },
        out: function(ev, ui){
            rechange_user_bg($(this));
        },

        drop: function(ev, ui) {
          var item      = ui.draggable;
          var userId    = $(this).attr("id");
          var itemId    = item.attr("id");
          userId = userId.replace('user_','');
          itemId = itemId.replace('item_','');
          rechange_user_bg($(this));

          // Perform Ajax call and add item to user
          addItem(userId, itemId);

          // Change DOM and Append Item to User
          item.appendTo($(this));
        }
    });

    // FREE-ITEMS (Target - Source)
    $("#free_items").droppable({
        //hoverClass: "draghovered",
        over: function(ev, ui){
            $(this).css('background-image', 'url("/images/icons/drop_bg.png")');
        },
        out: function(ev, ui){
           rechange_freeitems_bg($(this));
        },
        drop: function(ev, ui) {
          var item      = ui.draggable;
          var itemId    = item.attr("id");
          rechange_freeitems_bg($(this));
          itemId = itemId.replace('item_','');

          // Perform Ajax call and set Item free
          freeItem(itemId);

          item.appendTo($(this));
        }
    });

    // --- Password Activate/Deactivate
    $('#events_password_chk').change(function(){
        if ($(this).is(':checked'))
            $('#pw_input').fadeIn();
        else
            $('#pw_input').fadeOut();
    })

});

// ADD Item To USER (ajax)
function addItem(user_id, item_id) {
    var url = '/items/assign_user/'+ item_id +'.js';
    $.ajax({
      type: 'POST',
      url: url,
      data: ({user_id:user_id})
    });
}

// ADD Item To USER (ajax)
function freeItem(item_id) {
    var url = '/items/set_free/'+ item_id +'.js';
    $.ajax({
      type: 'POST',
      url: url
    });
}