
setupWebViewJavascriptBridge(function(bridge){
                             
                             var uniqueId = 1
                             function log(message, data) {
                             var log = document.getElementById('log')
                             var el = document.createElement('div')
                             el.className = 'logLine'
                             el.innerHTML = uniqueId++ + '. ' + message + ':<br/>' + JSON.stringify(data)
                             if (log.children.length) { log.insertBefore(el, log.children[0]) }
                             else { log.appendChild(el) }
                             }
                             
                             bridge.registerHandler('ObjcCallJS', function(data, responseCallback) {
                                                 setDivValue(data)
                                                    log('ObjC called testJavascriptHandler with', data)
                                                
                                                    responseCallback(responseData)
                                                    })
                             
                             })

})

function setDivValue(data){
                             
    var div = document.getElementById('label');
    div.innerHTML = '随机数:' +  data;

}

function jump(){
                             var object = event.srcElement;
    bridge.callHandler('JSCallObjc', {'key':'value'}, function responseCallback(responseData) {
                       console.log("JS received response:", responseData);
                    })
}
