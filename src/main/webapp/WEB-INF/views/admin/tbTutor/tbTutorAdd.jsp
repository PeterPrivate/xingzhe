<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#tbTutorAddForm').form({
            url : '${path}/tbTutor/add',
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
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#tbTutorAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        $('#typeDomain').combobox({
            editable:false,
            multiple:true,
            formatter:function(row){
                return '<option value="'+row.id+'">'+row.name+'</option>';
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: auto;padding: 3px;" >
        <form id="tbTutorAddForm" method="post">
            <table class="grid">
                <tr><td>排序值（越大越排前，默认1）</td>
                    <td><input name="sortValue" type="text" placeholder="请输入数值"
                                           class="easyui-validatebox span2" data-options="required:true"
                                           value="1"></td></tr>
                <tr>
                <tr>
                    <td>姓名</td>
                    <td><input name="name" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>头像</td>
                    <td>
                        <!--dom结构部分-->
                        <div class="uploder-container">
                            <p>悬停图片移除，请保证图片为方形</p>
                            <div  class="cxuploder">
                                <div class="queueList">
                                    <div class="placeholder">
                                        <div class="filePicker"></div>
                                        <p>将照片拖到这里</p>
                                    </div>
                                </div>

                                <div class="statusBar" style="display:none;">


                                    <div class="btns">
                                        <div  class="jxfilePicker"></div>

                                    </div>
                                    <div class="info"></div>
                                </div>
                            </div>
                            <input class="input" hidden="hidden" type="text" name="headImg" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="">是否首页展示</td>
                    <td style="text-align:left">
                        <span class="radioSpan">
                            <input type="radio" name="isHomeDisplay" value="0" >是</input>
                            <input type="radio" name="isHomeDisplay" value="1">否</input>
                        </span>
                    </td>
                </tr>
                <tr class="extra">
                    <td>头像(首页展示需上传额外头像）</td>
                    <td>
                        <!--dom结构部分-->
                        <div class="uploder-container">
                            <p>悬停图片移除，请保证图片大小210*250</p>
                            <div  class="cxuploder">
                                <div class="queueList">
                                    <div class="placeholder">
                                        <div class="filePicker"></div>
                                        <p>将照片拖到这里</p>
                                    </div>
                                </div>

                                <div class="statusBar" style="display:none;">


                                    <div class="btns">
                                        <div  class="jxfilePicker"></div>

                                    </div>
                                    <div class="info"></div>
                                </div>
                            </div>
                            <input class="input" hidden="hidden" type="text" name="headImgExtra" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>公司</td>
                    <td><input name="company" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>职位</td>
                    <td><input name="position" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>常住地</td>
                    <td><input name="permanentLand" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>简短简介</td>
                    <td><input name="shortIntro" class="easyui-textbox" data-options="multiline:true" value="" style="width:300px;height:100px"></td>
                </tr>
                <tr>
                    <td>简介</td>
                    <td><input name="intro" class="easyui-textbox" data-options="multiline:true" value="" style="width:300px;height:100px"></td>
                </tr>
                <tr>
                    <td>是否大咖(是将展示在学院大咖导师一栏）</td>
                    <td style="text-align:left">
                        <span class="radioSpan">
                            <input type="radio" name="isMaster" value="0">是</input>
                            <input type="radio" name="isMaster" value="1">否</input>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>领域类型</td>
                    <td><input id="typeDomain" name="domainTypes" style="width: 100px"
                               url="tbTypeDomain/dataAll?page=1&rows=100&sort=id&order=asc" valueField="id" textField="name"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="${staticPath }/static/webuploader/webuploader.css">
<link href="${staticPath }/static/admin/cxuploader.css" rel="stylesheet" />
<!--引入JS-->
<script type="text/javascript" charset="utf-8" src="${staticPath }/static/webuploader/webuploader.min.js"></script>

<script type="text/javascript" charset="utf-8" src="${staticPath }/static/admin/cxuploader.js"></script>
<script type="text/javascript">
    $(function(){
        loadWebUploader();
        var i = 1;
        $('.radioSpan input:radio[name=isHomeDisplay]').click(function(){
            var index=$(this).index();
            console.log(index);
            if(index==0){
                $('.extra').show();

            }else if(index==1){
                $('.extra').hide();

            }
            if(i>1) destroyWebUploader();
            loadWebUploader();
            i++;
        })
        $('.radioSpan input:radio[name=isHomeDisplay][value="1"]').click();
    })
</script>

