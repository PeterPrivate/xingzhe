    uploader = new Array();//创建 uploader数组
    var loadWebUploader = function() {


    	// 优化retina, 在retina下这个值是2
        var ratio = window.devicePixelRatio || 1,
        // 缩略图大小
        thumbnailWidth = 100 * ratio,
        thumbnailHeight = 100 * ratio,
        supportTransition = (function(){
            var s = document.createElement('p').style,
            r = 'transition' in s ||
                  'WebkitTransition' in s ||
                  'MozTransition' in s ||
                  'msTransition' in s ||
                  'OTransition' in s;
	        s = null;
	        return r;
        })();
     	// 所有文件的进度信息，key为file id
        var percentages = {};
        var state = 'pedding';
    	
    	//可行性判断
    	if ( !WebUploader.Uploader.support() ) {
            alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
            throw new Error( 'WebUploader does not support the browser you are using.' );
        }
    	
    	//循环页面中每个上传域
    	$('.uploder-container').each(function(index){
    		// 添加的文件数量
            var fileCount = 0;
            // 添加的文件总大小
            var fileSize = 0;
    		
    		var filePicker=$(this).find('.filePicker');//上传按钮实例
    		var queueList=$(this).find('.queueList');//拖拽容器实例
    		var jxfilePicker=$(this).find('.jxfilePicker');//继续添加按钮实例
    		var placeholder=$(this).find('.placeholder');//按钮与虚线框实例
    		var statusBar=$(this).find('.statusBar');//再次添加按钮容器实例
            var input = $(this).find('.input');//传值输入框
    		var info =statusBar.find('.info');//提示信息容器实例
    		queueList.find('.filelist').remove();
    		// 图片容器       	
    		var queue = $('<ul class="filelist"></ul>').appendTo( queueList);
    		
    		//初始化上传实例
            uploader[index] = WebUploader.create({
                pick: {
                    id: filePicker,
                    label: '上传'
                },
                dnd: queueList,
               
                //这里可以根据 index 或者其他，使用变量形式
                accept: {
                    title: 'Images',
                    extensions: 'gif,jpg,jpeg,bmp,png',
                    mimeTypes: 'image/jpg,image/jpeg,image/png,image/gif,image/bmp'
                },

                // swf文件路径
                swf: 'res/Uploader.swf',
                fileVal:"upfile",
                disableGlobalDnd: true,//禁用浏览器的拖拽功能，否则图片会被浏览器打开

                chunked: false,//是否分片处理大文件的上传
                            
                server: 'ueditor?action=uploadimage',//上传地址
                
                fileNumLimit: 1,//一次最多上传文件个数
                
                fileSizeLimit: 10 * 1024 * 1024,    // 总共的最大限制10M
                
                fileSingleSizeLimit: 3 * 1024 * 1024 ,   // 单文件的最大限制3M
                
                auto :true,
                
                formData: {                
                	token:index//可以在这里附加控件编号，从而区分是哪个控件上传的
                }
            });
    		

            // 添加“添加文件”的按钮
            /*uploader[index].addButton({
                id: jxfilePicker,
                label: '继续添加'
            });*/
            
            //当文件加入队列时触发	uploader[0].upload();
            uploader[index].onFileQueued = function( file ) {
    			fileCount++;
                fileSize += file.size;

                if ( fileCount === 1 ) {
                	placeholder.addClass( 'element-invisible' );
                    statusBar.show();
                }
                
                addFile( file,uploader[index],queue);
                setState( 'ready' ,uploader[index],placeholder,queue,statusBar,jxfilePicker);
                updateStatus('ready',info,fileCount,fileSize);
            };
            //加载的时候
            uploader[index]	.on('ready',function(){
                var files = new Array();
                var xhr = $.ajax({
                    type: "HEAD",
                    url: input.val(),
                    success: function(msg){

                        var temp = new Object();
                temp.id=index;
                temp.name=index;
                temp.type='image/jpeg';

                temp.size=xhr.getResponseHeader('Content-Length');
                temp.url=input.val();
                files.push(temp);
                for(var i = 0; i < files.length; i++){
                    var obj ={};
                    statusMap = {};
                    fileCount++;
                    fileSize += files[i].size;
                    if ( fileCount === 1 ) {
                        placeholder.addClass( 'element-invisible' );
                        statusBar.show();
                    }
                    obj.id=files[i].id;
                    obj.name=files[i].name;
                    obj.type=files[i].type;
                    obj.size=files[i].size;
                    obj.ret=files[i].url;
                    obj.source=null;
                    obj.flog=true;
                    obj.status = 'complete',
                        obj.getStatus = function(){
                            return '';
                        }
                    obj.version = WebUploader.Base.version;
                    obj.statusText = '';
                    obj.setStatus = function(){
                        var prevStatus = statusMap[this.id];
                        typeof text !== 'undefined' && (this.statusText = text);
                        if(status !== prevStatus){
                            statusMap[this.id] = status;
                            //文件状态设置为已完成
                            uploader[index].trigger('statuschage',status,prevStatus);
                        }
                    }
                    // console.log("这是你要的obj：" + JSON.stringify(obj));
                    addFile( obj,uploader[index],queue,index);
                    setState( 'ready' ,uploader[index],placeholder,queue,statusBar,jxfilePicker);
                    updateStatus('ready',info,fileCount,fileSize);
                }
                        // alert(xhr.getResponseHeader('Content-Length') + ' bytes');

                    }
                });
        });
    		//当文件被移除队列后触发。
            uploader[index].onFileDequeued = function( file ) {
            	fileCount--;
                fileSize -= file.size;

                if ( !fileCount ) {
                    setState( 'pedding',uploader[index],placeholder,queue,statusBar,jxfilePicker);
                    updateStatus('pedding',info,fileCount,fileSize);
                }              
                removeFile( file );
              
	
            };
            
            uploader[index].on('uploadSuccess',function(file,reponse){
            	if(reponse && reponse.state=="SUCCESS"){
                    console.log("上传成功")
            	    input.val(reponse.url);
                }
            });
            

            //可以在这里附加额外上传数据
            
            uploader[index].on('uploadBeforeSend',function(object,data,header) {
            	/*var tt=$("input[name='id']").val();
            	data=$.extend(data,{
            		modelid:tt
            		});*/
                /*alert("上传前触发");*/
            });
    		
    	});
    	
    	
    	
        // 当有文件添加进来时执行，负责view的创建
        function addFile( file,now_uploader,queue) {
            if(now_uploader.getStats().queueNum>now_uploader.option().fileNumLimit) return;
            var $li = $( '<li id="' + file.id + '">' +
                    '<p class="title">' + file.name + '</p>' +
                    '<p class="imgWrap"></p>'+
                    '<p class="progress"><span></span></p>' +
                    '</li>' ),

                $btns = $('<div class="file-panel">' +
                    '<span class="cancel">删除</span>' +
                    '<span class="rotateRight">向右旋转</span>' +
                    '<span class="rotateLeft">向左旋转</span></div>').appendTo( $li ),
                $prgress = $li.find('p.progress span'),
                $wrap = $li.find( 'p.imgWrap' ),
                $info = $('<p class="error"></p>');
                
            $wrap.text( '预览中' );
            if(file.flog == true){
            	var img = $('<img src="'+file.ret+'">');
                $wrap.empty().append( img );
            }else{
            	now_uploader.makeThumb( file, function( error, src ) {
                    if ( error ) {
                        $wrap.text( '不能预览' );
                        return;
                    }

                    var img = $('<img src="'+src+'">');
                    $wrap.empty().append( img );
                }, thumbnailWidth, thumbnailHeight );
            }

            percentages[ file.id ] = [ file.size, 0 ];
            file.rotation = 0;
           
           /*
            file.on('statuschange', function( cur, prev ) {
                if ( prev === 'progress' ) {
                    $prgress.hide().width(0);
                } else if ( prev === 'queued' ) {
                    $li.off( 'mouseenter mouseleave' );
                    $btns.remove();
                }

                // 成功
                if ( cur === 'error' || cur === 'invalid' ) {
                    console.log( file.statusText );
                    showError( file.statusText );
                    percentages[ file.id ][ 1 ] = 1;
                } else if ( cur === 'interrupt' ) {
                    showError( 'interrupt' );
                } else if ( cur === 'queued' ) {
                    percentages[ file.id ][ 1 ] = 0;
                } else if ( cur === 'progress' ) {
                    $info.remove();
                    $prgress.css('display', 'block');
                } else if ( cur === 'complete' ) {
                    $li.append( '<span class="success"></span>' );
                }

                $li.removeClass( 'state-' + prev ).addClass( 'state-' + cur );
            });
            */

            
            $li.on( 'mouseenter', function() {
                $btns.stop().animate({height: 30});
            });

            $li.on( 'mouseleave', function() {
                $btns.stop().animate({height: 0});
            });
            

            $btns.on( 'click', 'span', function() {
                var index = $(this).index(),
                    deg;

                switch ( index ) {
                    case 0:
                    	now_uploader.removeFile( file );
                        return;

                    case 1:
                        file.rotation += 90;
                        break;

                    case 2:
                        file.rotation -= 90;
                        break;
                }

                if ( supportTransition ) {
                    deg = 'rotate(' + file.rotation + 'deg)';
                    $wrap.css({
                        '-webkit-transform': deg,
                        '-mos-transform': deg,
                        '-o-transform': deg,
                        'transform': deg
                    });
                } else {
                    $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
                    
                }


            });

            $li.appendTo(queue);
        }
    	
    	
        // 负责view的销毁
        function removeFile( file ) {
            var $li = $('#'+file.id);
            delete percentages[ file.id ];
           
            $li.off().find('.file-panel').off().end().remove();
        } 
    	
        
        function setState( val, now_uploader,placeHolder,queue,statusBar,jxfilePicker) {
            
            switch ( val ) {
                case 'pedding':
                    placeHolder.removeClass( 'element-invisible' );
                    queue.parent().removeClass('filled');
                    queue.hide();
                    statusBar.addClass( 'element-invisible' );
                    now_uploader.refresh();
                    break;

                case 'ready':
                    placeHolder.addClass( 'element-invisible' );
                    jxfilePicker.removeClass( 'element-invisible');
                    queue.parent().addClass('filled');
                    queue.show();
                    statusBar.removeClass('element-invisible');
                    now_uploader.refresh();
                    break;              
            }

            
        }
        
        function updateStatus(val,info,f_count,f_size) {
            var text = '';

            if ( val === 'ready' ) {
                text = '选中' + f_count + '张图片，共' +
                        WebUploader.formatSize( f_size ) + '。';
            } 

            info.html( text );
        } 
        
        
    	
   
    };
var destroyWebUploader = function () {
    for(var index in uploader){
        uploader[index].destroy();

    }
}
var refreshWebUploader = function () {
    for(var index in uploader){
        uploader[index].refresh();
    }
}