<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tbInvitationDataGrid;
    $(function() {

        tbInvitationDataGrid = $('#tbInvitationDataGrid').datagrid({
        url : '${path}/tbInvitation/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : false,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns : [ [{
            field : 'ck',
            checkbox : true,

        }, {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true
        },{
            width : '60',
            title : '主办方',
            field : 'sponsor',
            sortable : true
        },{
            width : '60',
            title : '联系人',
            field : 'linkman',
            sortable : true
        },{
            width : '100',
            title : '手机号',
            field : 'phone',
            sortable : true
        },{
            width : '60',
            title : '需求描述',
            field : 'desc',
            sortable : true
        },{
            width : '60',
            title : '预算',
            field : 'budget',
            sortable : true
        },{
            width : '100',
            title : '导师',
            field : 'tutorId',
            sortable : true,
            formatter : function (value, row, index) {
                var tutorName;
                $.post('tbTutor/dataAll?id='+row.tutorId+'&page=1&rows=100&sort=id&order=asc', function(data) {

                    tutorName = $.parseJSON( data )[0].name;
                    $('#tutorId-'+index).text(tutorName+"(编号："+row.tutorId+")");
                });
                var str = '';
                str += $.formatString('<span id="tutorId-{0}"></span>', index);
                return str;

            }
        }, {
            width : '60',
            title : '处理状态',
            field : 'handleStatus',
            sortable : true,
            formatter : function(value, row, index) {
                switch (value) {
                    case 0:
                        return '未处理';
                    case 1:
                        return '已处理';
                }
            }
        }, {
            width : '60',
            title : '状态',
            field : 'status',
            sortable : true,
            formatter : function(value, row, index) {
                switch (value) {
                case 0:
                    return '正常';
                case 1:
                    return '停用';
                }
            }
        }, {
            width : '140',
            title : '创建时间',
            field : 'createTime',
            sortable : true
        }, {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/tbInvitation/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="tbInvitation-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tbInvitationEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tbInvitation/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="tbInvitation-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tbInvitationDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.tbInvitation-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.tbInvitation-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#tbInvitationToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function tbInvitationAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 600,
        href : '${path}/tbInvitation/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbInvitationDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbInvitationAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function tbInvitationEditFun(id) {
    if (id == undefined) {
        var rows = tbInvitationDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        tbInvitationDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 600,
        href :  '${path}/tbInvitation/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbInvitationDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbInvitationEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function tbInvitationDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = tbInvitationDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         tbInvitationDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/tbInvitation/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     tbInvitationDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}
    /**
     * 批量删除
     */
    function tbInvitationBatchDeleteFun() {

        var rows = tbInvitationDataGrid.datagrid('getSelections');
        if(rows.length < 1){
            parent.$.messager.alert("提示消息","请选择要删除的记录！",'info');
            return;
        }
        parent.$.messager.confirm('询问', '您是否要删除当前所选邀请函？', function(b) {
            if (b) {
                progressLoad();
                //定义变量值
                var strIds = "";
                //拼接字符串，这里也可以使用数组，作用一样
                for (var i = 0; i < rows.length; i++) {
                    strIds += rows[i].id + ",";
                }
                //循环切割
                strIds = strIds.substr(0, strIds.length - 1);
                $.post('${path}/tbInvitation/batchDelete', {
                    strIds : strIds
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        tbInvitationDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }

/**
 * 清除
 */
function tbInvitationCleanFun() {
    $('#tbInvitationSearchForm input').val('');
    tbInvitationDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function tbInvitationSearchFun() {
     tbInvitationDataGrid.datagrid('load', $.serializeObject($('#tbInvitationSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="tbInvitationSearchForm">
            <table>
                <tr>
                    <th>主办方／联系人:</th>
                    <td><input name="q" placeholder="搜索条件"/></td>
                    <th>手机号:</th>
                    <td><input name="phone" placeholder="手机号"/></td>
                    <th>处理状态:</th>
                    <td><select  name="handleStatus">
                        <option></option>
                        <option value="0">未处理</option>
                        <option value="1">已处理</option>
                    </select></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tbInvitationSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tbInvitationCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="tbInvitationDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="tbInvitationToolbar" style="display: none;">
    <shiro:hasPermission name="/tbInvitation/add">
        <a onclick="tbInvitationAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/tbInvitation/delete">
        <a onclick="tbInvitationBatchDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-delete'">批量删除</a>
    </shiro:hasPermission>
</div>