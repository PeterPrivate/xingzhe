<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#tbOpenClassEditForm').form({
            url : '${path}/tbOpenClass/edit',
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
                    var form = $('#tbOpenClassEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        var curr_time =new Date($('#startTime').val());
        var strDate = curr_time.getFullYear() + "-";
        strDate += curr_time.getMonth() + 1 + "-";
        strDate += curr_time.getDate() + "-";
        strDate += " " + curr_time.getHours() + ":";
        strDate += curr_time.getMinutes() + ":";
        strDate += curr_time.getSeconds();

        $('#startTime').datetimebox({
            value : strDate,
            required : true,
            showSeconds : false
        });
        var curr_time =new Date($('#endTime').val());
        var strDate = curr_time.getFullYear() + "-";
        strDate += curr_time.getMonth() + 1 + "-";
        strDate += curr_time.getDate() + "-";
        strDate += " " + curr_time.getHours() + ":";
        strDate += curr_time.getMinutes() + ":";
        strDate += curr_time.getSeconds();

        $('#endTime').datetimebox({
            value : strDate,
            required : true,
            showSeconds : false
        });
        $("#editStatus").val('${tbOpenClass.status}'); 
        
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: auto;padding: 3px;">
        <form id="tbOpenClassEditForm" method="post">
            <table class="grid">
                <tr>
                    <td>课程名</td>
                    <td><input name="id" type="hidden"  value="${tbOpenClass.id}">
                        <input name="courseName" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value="${tbOpenClass.courseName}"></td>
                </tr>
                <tr>
                    <td>宣传图片</td>
                    <td>
                        <!--dom结构部分-->
                        <div id="uploader-demo">
                            <!--用来存放item-->
                            <div id="fileList" class="uploader-list"></div>
                            <div id="filePicker">选择图片</div>
                        </div>
                        <input hidden="hidden" id="imgPath" type="text" name="imgPath" value="${tbOpenClass.imgPath}">
                        </input>
                    </td>
                </tr>
                <tr>
                    <td>主办方</td>
                    <td><input name="sponsor" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value="${tbOpenClass.sponsor}"></td>
                </tr>
                <tr>
                    <td>讲师</td>
                    <td><input name="lecturer" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value="${tbOpenClass.lecturer}"></td>
                </tr>
                <tr>
                    <td>地点</td>
                    <td><input name="place" class="easyui-textbox" data-options="multiline:true" value="${tbOpenClass.place}" style="width:300px;height:100px"></td>
                </tr>
                <tr>
                    <td>开始时间</td>
                    <td><input id="startTime" type="text" name="startTime" value="${tbOpenClass.startTime}"></td>
                </tr>
                <tr>
                    <td>结束时间</td>
                    <td><input id="endTime" type="text" name="endTime" value="${tbOpenClass.endTime}"></td>
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
<%@ include file="/commons/webuploader.jsp" %>