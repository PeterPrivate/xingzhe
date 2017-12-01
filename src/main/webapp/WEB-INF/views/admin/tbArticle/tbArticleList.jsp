<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tbArticleDataGrid;
    $(function() {
        var typeArticle,typeSource;
        $.post("tbTypeArticle/dataAll?page=1&rows=100&sort=id&order=asc", function(data) {
            typeArticle = data;
            $.post("tbTypeSource/dataAll?page=1&rows=100&sort=id&order=asc", function(data) {
                typeSource = data;
                tbArticleDataGrid = $('#tbArticleDataGrid').datagrid({
                    url : '${path}/tbArticle/dataGrid',
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
                        title : '标题',
                        field : 'title',
                        sortable : true
                    },  {
                        width : '60',
                        title : '排序值',
                        field : 'sortValue',
                        sortable : true
                    }, {
                        width : '60',
                        title : '标题图片',
                        field : 'titleImg',
                        formatter :  function(value, row, index) {
                            var str = '';
                            str += $.formatString('<img src="{0}" height="30" width="55"></img>', row.titleImg);
                            return str;
                        }
                    }, {
                        width : '60',
                        title : '简介',
                        field : 'intro',
                        sortable : true
                    },{
                        width : '60',
                        title : '文章类型',
                        field : 'articleType',
                        sortable : true,
                        formatter :  function(value, row, index) {
                            var str = '';
                            $.each(typeArticle, function (index, obj) {
                                if(obj.id==row.articleType ){
                                    str = obj.name;
                                }
                            });
                            return str;
                        }
                    },{
                        width : '60',
                        title : '来源',
                        field : 'sourceType',
                        sortable : true,
                        formatter :  function(value, row, index) {
                            var str = '';
                            $.each(typeSource, function (index, obj) {
                                if(obj.id==row.sourceType ){
                                    str = obj.name;
                                }
                            });
                            return str;
                        }
                    },{
                        width : '140',
                        title : '发布时间',
                        field : 'showTime',
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
                            <shiro:hasPermission name="/tbArticle/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="tbArticle-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tbArticleEditFun(\'{0}\');" >编辑</a>', row.id);
                            </shiro:hasPermission>
                            <shiro:hasPermission name="/tbArticle/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="tbArticle-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tbArticleDeleteFun(\'{0}\');" >删除</a>', row.id);
                            </shiro:hasPermission>
                            return str;
                        }
                    } ] ],
                    onLoadSuccess:function(data){
                        $('.tbArticle-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                        $('.tbArticle-easyui-linkbutton-del').linkbutton({text:'删除'});
                    },
                    toolbar : '#tbArticleToolbar'
                });
            },"json");
        },"json");
        $('.typeSource').combobox({
            formatter:function(row){
                return '<option value="'+row.id+'">'+row.name+'</option>';
            }
        });
        $('.typeArticle').combobox({
            formatter:function(row){
                return '<option value="'+row.id+'">'+row.name+'</option>';
            }
        });
});

/**
 * 添加框
 * @param url
 */
function tbArticleAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 600,
        href : '${path}/tbArticle/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbArticleDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbArticleAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function tbArticleEditFun(id) {
    if (id == undefined) {
        var rows = tbArticleDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        tbArticleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 600,
        href :  '${path}/tbArticle/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbArticleDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbArticleEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function tbArticleDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = tbArticleDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         tbArticleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/tbArticle/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     tbArticleDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}
    /**
     * 批量删除
     */
    function tbArticleBatchDeleteFun() {

        var rows = tbArticleDataGrid.datagrid('getSelections');
        if(rows.length < 1){
            parent.$.messager.alert("提示消息","请选择要删除的记录！",'info');
            return;
        }
        parent.$.messager.confirm('询问', '您是否要删除当前所选文章？', function(b) {
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
                $.post('${path}/tbArticle/batchDelete', {
                    strIds : strIds
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        tbArticleDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }


/**
 * 清除
 */
function tbArticleCleanFun() {
    $('#tbArticleSearchForm input').val('');
    tbArticleDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function tbArticleSearchFun() {
     tbArticleDataGrid.datagrid('load', $.serializeObject($('#tbArticleSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="tbArticleSearchForm">
            <table>
                <tr>
                    <th>标题:</th>
                    <td><input name="q" placeholder="搜索条件"/></td>
                    <th>文章类型:</th>
                    <td><input class="typeArticle" name="articleType" style="width: 100px"
                               url="tbTypeArticle/dataAll?page=1&rows=100&sort=id&order=asc" valueField="id" textField="name">
                        </input></td>
                    <th>来源:</th>
                    <td><input class="typeSource" name="sourceType" style="width: 100px"
                               url="tbTypeSource/dataAll?page=1&rows=100&sort=id&order=asc" valueField="id" textField="name">
                        </input></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tbArticleSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tbArticleCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="tbArticleDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="tbArticleToolbar" style="display: none;">
    <shiro:hasPermission name="/tbArticle/add">
        <a onclick="tbArticleAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/tbArticle/delete">
        <a onclick="tbArticleBatchDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-delete'">批量删除</a>
    </shiro:hasPermission>
</div>
