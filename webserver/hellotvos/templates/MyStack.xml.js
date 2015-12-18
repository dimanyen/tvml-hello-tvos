/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
A stack template shows stacked rows of items beneath a banner, such as movies, TV shows, or products. The user can navigate through the rows and products to focus on one.
*/
var Template = function(data) { 
  var items = creatItem(data);
  // console.log("len:" + data["contents"].length);
  return `<?xml version="1.0" encoding="UTF-8" ?>
<document>
  <head>
    <style>
    .imageWithGradient {
      tv-tint-color: linear-gradient(top, 0.33, transparent, 0.66, rgba(0,64,0,0.7), rgba(0,64,0,1.0));
    }
    .showTextOnHighlight {
      tv-text-highlight-style: show-on-highlight;
    }
    .scrollTextOnHighlight {
      tv-text-highlight-style: marquee-on-highlight;
    }
    .showAndScrollTextOnHighlight {
      tv-text-highlight-style: marquee-and-show-on-highlight;
    }
    </style>
  </head>
  <stackTemplate>
    <collectionList>
      
      <shelf>
        <header>
          <title>My AppTV APP</title>
        </header>
        <section>
          ${items}         
        </section>
      </shelf>      
    </collectionList>
  </stackTemplate>
</document>`
}

var creatItem = function(data){
  var xml = "";
  console.log("len:" + data["contents"].length);
  for (var i = 0; i < data["contents"].length; i++) {
    var url = data["contents"][i];
    var videoURL = data["videoURL"];
    var itemXML = `
    <lockup videoURL="${videoURL}">
        <img src="${this.BASEURL}${url}" width="202" height="202" />
        <title class="showTextOnHighlight">Title ${i}</title>
    </lockup> `;
    xml += itemXML;
  };
  console.log("xml:" + xml);
  return xml;
}
