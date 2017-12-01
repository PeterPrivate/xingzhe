<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#tbInvitationEditForm').form({
            url : '${path}/tbInvitation/edit',
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
                    var form = $('#tbInvitationEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        
        $("#editStatus").val('${tbInvitation.status}');
        $("#editHandleStatus").val('${tbInvitation.handleRemarks}');
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
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="tbInvitationEditForm" method="post">
            <table class="grid">
                <tr>
                    <td>主办方</td>
                    <td><input name="id" type="hidden"  value="${tbInvitation.id}">
                    <input name="sponsor" type="text" placeholder="请输入名称" class="easyui-validatebox" data-options="required:true" value="${tbInvitation.sponsor}"></td>
                </tr>
                <tr>
                    <td>联系人</td>
                    <td><input name="linkman" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value="${tbInvitation.linkman}"></td>
                </tr>
                <tr>
                    <td>手机号</td>
                    <td><input name="phone" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value="${tbInvitation.phone}"></td>
                </tr>
                <tr>
                    <td>需求描述</td>
                    <td><input name="desc" class="easyui-textbox" data-options="multiline:true" value="${tbInvitation.desc}" style="width:300px;height:100px"></td>
                </tr>
                <tr>
                    <td>预算</td>
                    <td><input name="budget" type="text" placeholder="请输入名称" class="easyui-validatebox span2" data-options="required:true" value="${tbInvitation.budget}"></td>
                </tr>
                <tr>
                    <td>导师</td>
                    <td><input value="${tbInvitation.tutorId}" class="easyui-combobox" name="tutorId" id="tutorId" data-options="valueField:'id',textField:'name',panelHeight:'auto',panelMaxHeight:200,panelMinHeight:100"  style="width: 160px;height: 29px"/> </td>
                </tr>
                <tr>
                    <td>处理状态</td>
                    <td >
                        <select id="editHandleStatus" name="handleStatus" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0">未处理</option>
                            <option value="1">已处理</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>处理备注</td>
                    <td><input name="handleRemarks" class="easyui-textbox" data-options="multiline:true" value="${tbInvitation.handleRemarks}" style="width:300px;height:100px"></td>
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