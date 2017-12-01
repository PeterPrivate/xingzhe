<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="${staticPath }/static/webuploader/webuploader.css">
<!--引入JS-->
<script type="text/javascript" charset="utf-8" src="${staticPath }/static/webuploader/webuploader.min.js"></script>
<script type="text/javascript">
    // 初始化Web Uploader
    var $ = jQuery,
        $list = $('#fileList'),
        ratio = window.devicePixelRatio || 1,
        thumbnailWidth = 100 * ratio,
        thumbnailHeight = 100 * ratio,
        uploader;
    uploader = WebUploader.create({

        // 选完文件后，是否自动上传。
        auto: true,

        // swf文件路径
        swf:  '${staticPath }/webuploader/Uploader.swf',
        fileVal:"upfile",
        fileNumLimit:1,
        // 文件接收服务端。
        server: '${staticPath }/ueditor?action=uploadimage',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker',

        // 只允许选择图片文件。
        accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/jpg,image/jpeg,image/png,image/gif,image/bmp'
        }
    });

    uploader .on('ready',function(){
        if($('#imgPath').val()){
            var path = $('#imgPath').val();
            var $li = $(
                '<div id="' + 1 + '" class="file-item thumbnail">' +
                '<img src='+path+' height='+thumbnailHeight+' witdh='+thumbnailWidth+'>' +
                '<a class="file-panel" href="javascript:;" onclick="remove(\''+1+'\')">' +
                '<span class="fa fa-close">移除</span>' +
                '</a>' +
                '<div class="info">' + '图片预览' + '</div>' +
                '</div>'
            );
            $list.append( $li );
        }
    });
    //添加文件前
    uploader.on('beforeFileQueued',function(){
        console.log(uploader.getStats())
        if(uploader.getStats().successNum>=1 || uploader.getStats().progressNum>=1 || uploader.getStats().uploadFailNum>=1){
            alert("无法继续添加，请先移除")
            return false;
        }
    });
    // 当有文件添加进来的时候
    uploader.on( 'fileQueued', function( file ) {
        var $li = $(
                '<div id="' + file.id + '" class="file-item thumbnail">' +
                '<img>' +
                '<a class="file-panel" href="javascript:;" onclick="remove(\''+file.id+'\')">' +
                '<span class="fa fa-close">移除</span>' +
                '</a>' +
                '<div class="info">' + file.name + '</div>' +
                '</div>'
            ),
            $img = $li.find('img');

        // $list为容器jQuery实例
        $list.append( $li );

        // 创建缩略图
        // 如果为非图片文件，可以不用调用此方法。
        // thumbnailWidth x thumbnailHeight 为 100 x 100
        uploader.makeThumb( file, function( error, src ) {
            if ( error ) {
                $img.replaceWith('<span>不能预览</span>');
                return;
            }

            $img.attr( 'src', src );
        }, thumbnailWidth, thumbnailHeight );
    });
    // 文件上传过程中创建进度条实时显示。
    uploader.on( 'uploadProgress', function( file, percentage ) {
        var $li = $( '#'+file.id ),
            $percent = $li.find('.progress span');

        // 避免重复创建
        if ( !$percent.length ) {
            $percent = $('<p class="progress"><span></span></p>')
                .appendTo( $li )
                .find('span');
        }

        $percent.css( 'width', percentage * 100 + '%' );
    });

    // 文件上传成功，给item添加成功class, 用样式标记上传成功。
    uploader.on( 'uploadSuccess', function( file,res) {
        console.log(res)
        if(res && res.state){
            console.log(res.url)
            $("#imgPath").val(res.url);
            $( '#'+file.id ).addClass('upload-state-done');
        }else{
            var $li = $( '#'+file.id ),
                $error = $li.find('div.error');

            // 避免重复创建
            if ( !$error.length ) {
                $error = $('<div class="error"></div>').appendTo( $li );
            }

            $error.text('上传失败');
        }

    });

    // 文件上传失败，显示上传出错。
    uploader.on( 'uploadError', function( file ) {
        var $li = $( '#'+file.id ),
            $error = $li.find('div.error');

        // 避免重复创建
        if ( !$error.length ) {
            $error = $('<div class="error"></div>').appendTo( $li );
        }

        $error.text('上传失败');
    });

    // 完成上传完了，成功或者失败，先删除进度条。
    uploader.on( 'uploadComplete', function( file ) {
        $( '#'+file.id ).find('.progress').remove();
    });
    function remove(obj){
        $('#'+obj).remove();
        var html = '';
        $('#fileList').append(html);
        $("#imgPath").val('#');
        uploader.reset();
    }
</script>