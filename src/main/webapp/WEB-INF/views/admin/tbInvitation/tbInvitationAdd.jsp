<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#tbInvitationAddForm').form({
            url : '${path}/tbInvitation/add',
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
                    var form = $('#tbInvitationAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        $('#tutorId').combobox({
            prompt:'输入关键字自动检索',
            required:true,
            mode:'remote',
            url:'${path }/tbTutor/dataAll',
            editable:true,
            hasDownArrow:true,
            onBeforeLoad: function(param){
                if(param == null || param.q == null || param.q.replace(/ /g, '') == ''){
                    var value = $(this).combobox('getValue');
                    if(value){// 修改的时候才会出现q为空而value不为空
                        param.id = value;
                        return true;
                    }
                    return false;
                }
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="tbInvitationAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>主办方</td>
                    <td><input name="sponsor" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>联系人</td>
                    <td><input name="linkman" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>手机号</td>
                    <td><input name="phone" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>需求描述</td>
                    <td><input name="desc" class="easyui-textbox" data-options="multiline:true" value="" style="width:300px;height:100px"></td>
                </tr>
                <tr>
                    <td>预算</td>
                    <td><input name="budget" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>导师</td>
                    <td><input class="easyui-combobox" name="tutorId" id="tutorId" data-options="valueField:'id',textField:'name',panelHeight:'auto',panelMaxHeight:200,panelMinHeight:100"  style="width: 160px;height: 29px"/> </td>
                </tr>

            </table>
        </form>
    </div>
</div>