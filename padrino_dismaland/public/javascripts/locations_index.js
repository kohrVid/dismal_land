var curLoc = 19;

var authenticityToken;
var currentlyEditing = null;
window.onload = function() {
  //Show the first location
  showLocation(curLoc);
   //================Create==============================
  //csrf token below:
  authenticityToken = $("#comments").find("input[name=authenticity_token]").attr("value");
  $("#commentSubmitForm").click(function () {
    $.post("/comments", 
      {
	"comment[author]": $("#commentAuthor").val(),
	"comment[body]": $("#commentBody").val(),
	"comment[location_id]": curLoc,
	authenticity_token: authenticityToken
      },
      //The response function is a callback
      function (response) {
	if (typeof (response) == "string"){
	  response = JSON.parse(response);
	}
	locations[curLoc - 1].comments.unshift(response);
	$("#commentsIndex").prepend(buildComment(response));
      }
    );
  });
  $("#tagSubmitForm").click(function () {
    //csrf token below:
    authenticityToken = $("#tagForm").find("input[name=authenticity_token]").attr("value");
    $.post("/tags", 
      {
	"tag[name]": $("#tagName").val(),
	//"tag[locations][0][id]": curLoc,
	authenticity_token: authenticityToken
      }/*,
      //The response function is a callback
      function (response) {
	if (typeof (response) == "string"){
	  response = JSON.parse(response);
	}
	location[curLoc - 1].tags.unshift(response);
	$("#locationTags ul").prepend(buildComment(response));
      }*/
    );
  });
};

function showLocation(locNum) {
  $("#tagLocations").hide();
  $("#tagLocations ul").empty();
  $("#left").show();
  $("#comments").show();


  //========================Navigation button================================
  var loc = locations[locNum - 1];
  $("#locName").html(loc.name);
  $("#commentLocationId").attr("value", locNum);
  $("#locDesc").html(loc.description);
  $("#locPic").attr("src", "/images/" + loc.name.toLowerCase().replace(/ /g, "_") + ".gif");

  var myDiv = $("#directionLinks");
  myDiv.empty();
  
  for(var i = 0; i < loc.directions.length; i++){
    var direction = loc.directions[i];
    var myButton = $("<input>").attr("type", "button").attr("class", "button");

    myButton.attr("value", direction.direction + " --> " + locations[direction.destination_id - 1].name);
    myButton.on("click",
      function(cool_id) {
       return function () {
	  showLocation(cool_id);
	};
      } (direction.destination_id)
    );
    myDiv.append(myButton);
    myDiv.append($("<br>"));
  }
  curLoc = locNum;
  var commentDiv = $("#commentsIndex");
  commentDiv.empty();
  for(var i = 0; i < loc.comments.length; i++){
    var comment = loc.comments[i];
    commentDiv.append(buildComment(comment));
  }

  //=========Location Tags===================
  var localTags = loc.tags;
  $("#locationTags ul").empty();
  for (var i = 0; i < localTags.length; i++) {
    var currentTag = localTags[i];
    var tagLi = $("<li>");
    $(tagLi).append('<a href="#">' + currentTag.name + '</a>');
    $("#locationTags ul").append(tagLi);
  }

  //==================Tag Cloud===================
  var addTag = function(tag) {
  }

  $("#tagCloud").empty();
  for (var i = 0; i < tags.length; i++) {
    var tag_size = (tags[i].locations.length/1.5) + "rem";
    var tag_link = $('<a style="font-size:'+tag_size+';" href="#" id="' + tags[i].id + '">' + tags[i].name + '</a>');
    $("#tagCloud").append(tag_link);
    var tagId = "#" + tags[i].id;
    $(tagId).on("click", function(obj) {
     return function () {
	showTag(obj);
      };
    } (tags[i])
    );
    
  } 

}

//========================List Comments in Divs======
var buildComment = function(comment) { 
  var created_date = new Date(comment.created_at).toDateString().split(" ");
  var updated_date = new Date(comment.updated_at).toDateString().split(" ");
  var created_time = new Date(comment.created_at).toTimeString().split(" ");
  var updated_time = new Date(comment.updated_at).toTimeString().split(" ");
  var newComment = $('<div data-id="' + comment.id + '" class="commentText"></div>');
  newComment.append('<div class="commentAuthor"><strong>' + comment.author + 
      '</strong> says:</div><div class="commentBody">' + comment.body +
      '</div><small><div><strong>Posted at</strong> ' + 
      created_time[0] + " on " + created_date[2] + " " + created_date[1] +
      " " + created_date[3] + "</div><div><strong>Last updated at</strong> " +
      updated_time[0] + " on " + updated_date[2] + " " + updated_date[1] + " " +
      updated_date[3]  + "</div></small>");
  //=============================Updating======================
  newComment.find(".commentBody").on("click", function() {
    currentlyEditing = $(this);
    var newBody = $('<textarea id="editBody">' + currentlyEditing.html() + '</textarea>');
    currentlyEditing.replaceWith(newBody);
    newBody.on("keypress", function () {
      if (event.keyCode === 13){
	$.post("/comments/" + parseInt(newComment.attr("data-id")),
	  { 
	    "comment[body]": newBody.val(),
	    _method: "put", authenticity_token: authenticityToken
	  },
	  function (response) {
	    var myLoc = locations[curLoc - 1];
	    $("#commentsIndex").find(newComment).replaceWith(buildComment(response));
	  });
	 console.log("Submit");
       }
     });
  });
  //======================= Destroy Comments ===========================
  var destroyButton = $('<input type="button" class="button" value="DESTROY">');
  destroyButton.click( function () {
    $.post("/comments/" + comment.id,
      { _method: "delete", authenticity_token: authenticityToken },
      function (response) {
	var myLoc = locations[curLoc - 1];
	myLoc.comments = myLoc.comments.filter(function(c){
	  return c.id != response.id;
	});
	$("#commentsIndex").find(newComment).replaceWith(myLoc.comments);
      });
      console.log("I destroyed it!!!");
    });
    newComment.append(destroyButton);
    return newComment;
  }

//=========================Show Tags============================
function showTag(tag) {
  var locations = tag.locations;
  $("#tagLocations").show();
  $("#tagLocations ul").empty();
  $("#left").hide();
  $("#comments").hide();
  $("#directionLinks").empty();
  $("#locationTags ul").empty();
  for (var i = 0; i < locations.length; i++) {
    var loc = locations[i];
    var icon = $("<img>").attr("src", "/images/" + loc.name.toLowerCase().replace(/ /g, "_") + ".gif");
    var locDiv = $("<li>");
    $(locDiv).append("<strong>" + loc.name + "</strong>");
    $(locDiv).append("<p>");
    $(locDiv).append(icon);
    $(locDiv).append("</p>");
    $("#tagLocations ul").append(locDiv);
    locDiv.on("click",
      function(locationId) {
       return function () {
	  showLocation(locationId);
	};
      } (loc.id)
    );
  }
}

