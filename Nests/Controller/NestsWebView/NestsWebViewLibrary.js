window.onerror = function(err) {
    log('window.onerror: ' + err)
}

function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge)
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function() {
                                  callback(WebViewJavascriptBridge)
                                  }, false)
    }
}

connectWebViewJavascriptBridge(function(bridge) {
                               var uniqueId = 1
                               function log(message, data) {
                               var log = document.getElementById('log')
                               var el = document.createElement('div')
                               el.className = 'logLine'
                               el.innerHTML = uniqueId++ + '. ' + message + ':<br/>' + JSON.stringify(data)
                               if (log.children.length) { log.insertBefore(el, log.children[0]) }
                               else { log.appendChild(el) }
                               }
                               
                               //Object-c参数返回
                               bridge.init(function(message, responseCallback) {
                                           log('JS收到消息', message)
                                             //用户选择弹出框返回
                                           //{ "handler" : "alertObjectCHandler", "tag" : 1,  "selectIndex" : "1"}//tag用与表示那个弹出框JS传过来的，selectIndex表示选择的那个选项，handler表示消息是弹出框
                                           
                                           
                                           })
                               //JS提供接口给Object-c调用
                               bridge.registerHandler('callbackJavascriptHandler', function(data, responseCallback) {
                                                      log('ObjC called alertJavascriptHandler with', data)
                                                      var responseData = { 'message':'Right back atcha!','people':[
                                                                                                                   {'firstName':'Brett','lastName':'McLaughlin','email':'aaaa'},
                                                                                                                   
                                                                                                                   ]}
                                                      responseCallback(responseData)
                                                      })
                               
                               //JS调用Object-c接口
                               
                               var button = document.getElementById('buttons').appendChild(document.createElement('button'))
                               button.innerHTML = '发送消息给ObjectC'
                               button.onclick = function(e) {
                               e.preventDefault()
                               var data = '发送消息给ObjectC'
                               bridge.send(data, function(responseData) {
                                           log('ObjectC返回', responseData)
                                           })
                               }
                               
                                //弹出框1
                               document.body.appendChild(document.createElement('br'))
                               
                               var alertButton0 = document.getElementById('buttons').appendChild(document.createElement('button'))
                               alertButton0.innerHTML = '弹出按钮0'
                               alertButton0.onclick = function(e) {
                                e.preventDefault()
                          var jsonData =  {'title':'webAlert','message':'Right back atcha!', 'cancelButtonTitle':'取消', 'otherButtonTitles':['确定','确定1'],'tag':1}
                            bridge.callHandler('alertObjectCHandler', jsonData, function(response) {
                                                  log('ObjectC返回', response)
                                                  })
                               }
                               
                            
                               //弹出框2
                                   document.body.appendChild(document.createElement('br'))
            
                               var alertButton1 = document.getElementById('buttons').appendChild(document.createElement('button'))
                               alertButton1.innerHTML = '弹出按钮1'
                               alertButton1.onclick = function(e) {
                               e.preventDefault()
                               var jsonData =  {'title':'webAlert','message':'webAlert ok!', 'cancelButtonTitle':'确定','tag':100}
                               bridge.callHandler('alertObjectCHandler', jsonData, function(response) {
                                                  log('ObjectC返回', response)
                                                  })
                               }
                               
                               
                               
                               //返回按钮
                               document.body.appendChild(document.createElement('br'))
                               
                               var closeBtn = document.getElementById('buttons').appendChild(document.createElement('button'))
                               closeBtn.innerHTML = '返回'
                               closeBtn.onclick = function(e) {
                               e.preventDefault()
                               var jsonData =  {'message':'返回'}
                               bridge.callHandler('backBtnObjectCHandler', jsonData, function(response) {
                                                  log('ObjectC返回', response)
                                                  })
                               }
                               
                               
                               //设置导航
                               document.body.appendChild(document.createElement('br'))
                               
                               var  setBtn = document.getElementById('buttons').appendChild(document.createElement('button'))
                               setBtn.innerHTML = '设置导航'
                               setBtn.onclick = function(e) {
                               e.preventDefault()
                               var jsonData =  {'title':'导航标题','message':'导航标题','isHide':'NO'}
                               bridge.callHandler('navObjectCHandler', jsonData, function(response) {
                                                  log('ObjectC返回', response)
                                                  })
                               }

                               })


                                


