<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<script type="text/javascript">

    $(function() {

        $('#tbArticleEditForm').form({
            url : '${path}/tbArticle/edit',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#tbArticleEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        var curr_time =new Date($('#showTime').val());
        var strDate = curr_time.getFullYear() + "-";
        strDate += curr_time.getMonth() + 1 + "-";
        strDate += curr_time.getDate() + "-";
        strDate += " " + curr_time.getHours() + ":";
        strDate += curr_time.getMinutes() + ":";
        strDate += curr_time.getSeconds();

        $('#showTime').datetimebox({
            value : strDate,
            required : true,
            showSeconds : false
        });
        $('#typeSource').combobox({
            editable:false,
            formatter:function(row){
                return '<option value="'+row.id+'">'+row.name+'</option>';
            }
        });
        $('#typeArticle').combobox({
            editable:false,
            formatter:function(row){
                return '<option value="'+row.id+'">'+row.name+'</option>';
            }
        });
    });

    function getContent(){
        $('#content').val(UE.getEditor('editor').getPlainTxt());
        return true;
    }
    $("#editStatus").val('${tbArticle.status}');
</script>
<div class="easyui-layout" style="overflow: auto;height:600px" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false"
         style="overflow: auto; padding: 3px;">
        <form id="tbArticleEditForm" method="post" onsubmit="getContent()">
            <table class="grid">
                <tr><td colspan="2">排序值（越大越排前，默认1）</td>
                    <td colspan="2"><input name="sortValue" type="text" placeholder="请输入数值"
                               class="easyui-validatebox span2" data-options="required:true"
                               value="${tbArticle.sortValue}"></td></tr>
                <tr>
                    <td>标题<input name="id" type="hidden"  value="${tbArticle.id}"></td>
                    <td><input name="title" type="text" placeholder="请输入名称"
                               class="easyui-validatebox span2" data-options="required:true"
                               value="${tbArticle.title}"></td>
                    <td>日期</td>
                    <td><input id="showTime" type="text" name="showTime" value="${tbArticle.showTime}"></td>
                </tr>
                <tr>
                    <td>文章类型</td>
                    <td><input value="${tbArticle.articleType}" id="typeArticle" name="articleType" style="width: 100px"
                               url="tbTypeArticle/dataAll?page=1&rows=100&sort=id&order=asc" valueField="id" textField="name">
                        </input></td>
                    <td>來源</td>
                    <td><input value="${tbArticle.sourceType}" id="typeSource" name="sourceType" style="width: 100px"
                               url="tbTypeSource/dataAll?page=1&rows=100&sort=id&order=asc" valueField="id" textField="name">
                        </input></td>
                </tr>
                <tr>
                    <td>简介</td>
                    <td><input value="${tbArticle.intro}" name="intro" class="easyui-textbox" data-options="multiline:true" value="" style="width:300px;height:100px"></td>
                    <td>标题图片</td>
                    <td>
                        <!--dom结构部分-->
                        <div id="uploader-demo">
                            <!--用来存放item-->
                            <div id="fileList" class="uploader-list"></div>
                            <div id="filePicker">选择图片</div>
                        </div>
                        <input value="${tbArticle.titleImg}" hidden="hidden" id="titleImg" type="text" name="titleImg">
                        </input>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">内容<input id="content" name="content" hidden="hidden" type="text" placeholder="请输入名称"
                                             class="easyui-validatebox span2" data-options="required:true"
                                             value="${tbArticle.content}"></td>
                    <td colspan="3"><script id="editor" type="text/plain" style="width:650px;height:88px;"></script></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td >
                        <select id="editStatus" name="status" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0">正常</option>
                            <option value="1">停用</option>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="${staticPath }/static/webuploader/webuploader.css">
<!--引入JS-->
<script type="text/javascript" charset="utf-8" src="${staticPath }/static/webuploader/webuploader.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${staticPath }/static/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${staticPath }/static/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${staticPath }/static/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    function escape2Html(str) {
        if(str.indexOf("&#34;")){
            str = str.replace(/&#34;/ig,"&quot;");
        }
        var arrEntities={'&#34;':'"','lt':'<','gt':'>','nbsp':' ','amp':'&','quot':'"'};
        return str.replace(/&(lt|gt|nbsp|amp|quot);/ig,function(all,t){return arrEntities[t];});
    }
    ue.ready(function() {
        ue.setContent(escape2Html($('#content').val()));
    });
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
        var path = $('#titleImg').val();
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
    });

    //添加文件前
    uploader.on('beforeFileQueued',function(){
        console.log($list.find('img'))
        console.log(uploader.getStats())
        if($list.find('img').size()>0){
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
            $("#titleImg").val(res.url);
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
        $("#titleImg").val('#');
        uploader.reset();
    }
</script>