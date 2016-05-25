var PR = PR || {};

PR = (function(window, document, Prismatic){

  Prismatic.apiUrl = "http://localhost:6000/api/v1/events";
  var inited= false;
    
  Prismatic.analytic ={
    
    init: function(ob){
      if (!inited) {
        inited = true;
        Prismatic.analytic.app_key = ob.app_key || Prismatic.analytic.app_key || null;
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

      tracker = new Track(Prismatic.analytic.apiUrl,eventName,properties,Prismatic.analytic.contextInfo())
      tracker.send()
    },
    contextInfo : function(){
      return {
        context: Prismatic.util.pageDefaults(),
        browser: Prismatic.util.browserInfo(),
        session_id: Prismatic.analytic.session_id,
        user_id: Prismatic.analytic.userId,

      }
    },
    // sendXmlHttpRequest : function(path){
    //   var url = Prismatic.apiUrl + path;
    // }
    trackPageView: function(){
      {
        pageDefaults
      }
    }

  };
  return Prismatic;
})(this, this.document, PR);

