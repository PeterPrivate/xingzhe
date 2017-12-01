<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tbTypeArticleDataGrid;
    $(function() {
        tbTypeArticleDataGrid = $('#tbTypeArticleDataGrid').datagrid({
        url : '${path}/tbTypeArticle/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true
        }, {
            width : '60',
            title : '文章类型',
            field : 'name',
            sortable : true
        },{
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
                <shiro:hasPermission name="/tbTypeArticle/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="tbTypeArticle-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tbTypeArticleEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tbTypeArticle/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="tbTypeArticle-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tbTypeArticleDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.tbTypeArticle-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.tbTypeArticle-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#tbTypeArticleToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function tbTypeArticleAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 600,
        href : '${path}/tbTypeArticle/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbTypeArticleDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbTypeArticleAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function tbTypeArticleEditFun(id) {
    if (id == undefined) {
        var rows = tbTypeArticleDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        tbTypeArticleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 600,
        href :  '${path}/tbTypeArticle/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbTypeArticleDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbTypeArticleEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function tbTypeArticleDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = tbTypeArticleDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         tbTypeArticleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/tbTypeArticle/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     tbTypeArticleDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}


/**
 * 清除
 */
function tbTypeArticleCleanFun() {
    $('#tbTypeArticleSearchForm input').val('');
    tbTypeArticleDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function tbTypeArticleSearchFun() {
     tbTypeArticleDataGrid.datagrid('load', $.serializeObject($('#tbTypeArticleSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="tbTypeArticleSearchForm">
            <table>
                <tr>
                    <th>名称:</th>
                    <td><input name="name" placeholder="搜索条件"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tbTypeArticleSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tbTypeArticleCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="tbTypeArticleDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="tbTypeArticleToolbar" style="display: none;">
    <shiro:hasPermission name="/tbTypeArticle/add">
        <a onclick="tbTypeArticleAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a>
    </shiro:hasPermission>
</div>