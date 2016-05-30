var PR = PR || {};

PR = (function(window, document, Prismatic){

  Prismatic.apiUrl = "http://localhost:6000/api/v1/events";
  var inited= false;
    
  Prismatic.analytic ={
    
    init: function(ob){
      if (!inited) {
        inited = true;
        Prismatic.analytic.appId = ob.appId || Prismatic.analytic.appId || null;
        Prismatic.analytic.ip_address = ob.ip_address || Prismatic.ip_address || null;
        Prismatic.analytic.session_id = Prismatic.analytic.session_id || Prismatic.util.getSessionId();
        Prismatic.analytic.userId = ob.userId || null;
        Prismatic.analytic.apiUrl = ob.apiUrl || Prismatic.apiUrl
        store("prismatic_id", Prismatic.analytic.session_id);

      }  
    },
    logout: function(obj){
      store("prismatic_id", null);      
    },
    track : function(eventName,properties){
      // console.log(Prismatic.analytic.contextInfo())
      if(properties == undefined || properties == null){
        properties = {}
      }
      tracker = new Track(Prismatic.analytic.apiUrl,eventName,properties,Prismatic.analytic.contextInfo())
      tracker.send()
    },
    contextInfo : function(){
      return {
        context: Prismatic.util.pageDefaults(),
        browser: Prismatic.util.browserInfo(),
        session_id: Prismatic.analytic.session_id,
        user_id: Prismatic.analytic.userId,
        appId: Prismatic.analytic.appId

      }
    },
    // sendXmlHttpRequest : function(path){
    //   var url = Prismatic.apiUrl + path;
    // }
    trackPageView: function(properties){
      if(properties == undefined || properties == null){
        properties = {}
      }
      
      Prismatic.analytic.track("page_view",properties)
    }

  };
  return Prismatic;
})(this, this.document, PR);

