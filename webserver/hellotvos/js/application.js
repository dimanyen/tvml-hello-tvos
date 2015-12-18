App.onLaunch = function(options)
{	
	var javascriptfiles = [
		`${options.BASEURL}js/Presenter.js`,
		`${options.BASEURL}js/ResourceLoader.js`,
	];
	evaluateScripts(javascriptfiles,function(success){
		if (success) {
			var resource = new ResourceLoader(options.BASEURL);
			this.BASEURL = options.BASEURL;

			resource.httpRequest(`${this.BASEURL}resources/sample.json`,function(data){
				// console.log("len:" + data["contents"].length);
				resource.loadResourceWithArg(`${this.BASEURL}templates/MyStack.xml.js`,function(resource){
					var doc = Presenter.makeDocument(resource);
					doc.addEventListener("select",function(event)
						{
							var ele = event.target;
							var videoURL = ele.getAttribute("videoURL");
							Presenter.loadPlayer(videoURL);
						});
					Presenter.defaultPresenter(doc);

				},data);
			});

		}
		else
		{
			console.log("load fail");

		}

	});
	

	// navigationDocument.presentModal(helloTVOS());
}

var helloTVOS = function()
{
	var helloString = `<?xml version="1.0" encoding="UTF-8" ?>
    <document>
      <alertTemplate>
        <title>Hello tvOS</title>
        <img src="http://localhost/hellotvos1/resources/apptv.png" width="450" height="450"/>
        <button>
        	<text>click me</text>
        </button>      
      </alertTemplate>
    </document>`;
    var parser = new DOMParser();
    var alertDoc = parser.parseFromString(helloString,"application/xml");
    return alertDoc;

}

var createAlert = function(title,desc)
{
	var helloString = `<?xml version="1.0" encoding="UTF-8" ?>
    <document>
      <alertTemplate>
        <title>${title}</title>
        <description>${desc}</description>
      </alertTemplate>
    </document>`;
    var parser = new DOMParser();
    var alertDoc = parser.parseFromString(helloString,"application/xml");
    return alertDoc;

}