<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tbSlideshowDataGrid;
    $(function() {
        tbSlideshowDataGrid = $('#tbSlideshowDataGrid').datagrid({
        url : '${path}/tbSlideshow/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : false,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns : [ [ {
            field : 'ck',
            checkbox : true,

        },{
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true
        }, {
            width : '60',
            title : '是否文章',
            field : 'isArticle',
            sortable : true,
            formatter : function(value, row, index) {
                switch (value) {
                    case 0:
                        return '是';
                    case 1:
                        return '否';
                }
            }
        }, {
            width : '60',
            title : '名称',
            field : 'name',
            sortable : true
        }, {
            width : '60',
            title : '图片',
            field : 'imgPath',
            sortable : true,
            formatter :  function(value, row, index) {
                var str = '';
                str += $.formatString('<img src="{0}" height="30" width="55"></img>', row.imgPath);
                return str;
            }
        }, {
            width : '60',
            title : '图片指向',
            field : 'imgLink',
            sortable : true,
            formatter :  function(value, row, index) {
                var str = '';
                str += $.formatString('<a href="{0}" target="_blank">链接地址</a>', row.imgLink);
                return str;
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
                <shiro:hasPermission name="/tbSlideshow/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="tbSlideshow-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tbSlideshowEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tbSlideshow/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="tbSlideshow-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tbSlideshowDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.tbSlideshow-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.tbSlideshow-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#tbSlideshowToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function tbSlideshowAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 600,
        href : '${path}/tbSlideshow/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbSlideshowDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbSlideshowAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function tbSlideshowEditFun(id) {
    if (id == undefined) {
        var rows = tbSlideshowDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        tbSlideshowDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 600,
        href :  '${path}/tbSlideshow/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbSlideshowDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbSlideshowEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function tbSlideshowDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = tbSlideshowDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         tbSlideshowDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/tbSlideshow/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     tbSlideshowDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}
    /**
     * 批量删除
     */
    function tbSlideshowBatchDeleteFun() {

        var rows = tbSlideshowDataGrid.datagrid('getSelections');
        if(rows.length < 1){
            parent.$.messager.alert("提示消息","请选择要删除的记录！",'info');
            return;
        }
        parent.$.messager.confirm('询问', '您是否要删除当前所选轮播图？', function(b) {
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
                $.post('${path}/tbSlideshow/batchDelete', {
                    strIds : strIds
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        tbSlideshowDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }

/**
 * 清除
 */
function tbSlideshowCleanFun() {
    $('#tbSlideshowSearchForm input').val('');
    tbSlideshowDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function tbSlideshowSearchFun() {
     tbSlideshowDataGrid.datagrid('load', $.serializeObject($('#tbSlideshowSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="tbSlideshowSearchForm">
            <table>
                <tr>
                    <th>名称:</th>
                    <td><input name="q" placeholder="搜索条件"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tbSlideshowSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tbSlideshowCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="tbSlideshowDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="tbSlideshowToolbar" style="display: none;">
    <shiro:hasPermission name="/tbSlideshow/add">
        <a onclick="tbSlideshowAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/tbSlideshow/delete">
        <a onclick="tbSlideshowBatchDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-delete'">批量删除</a>
    </shiro:hasPermission>

</div>