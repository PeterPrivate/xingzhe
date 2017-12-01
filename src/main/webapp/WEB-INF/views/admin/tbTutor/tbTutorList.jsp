<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var tbTutorDataGrid;
    $(function() {
        var typeDomain;
        $.post("tbTypeDomain/dataAll?page=1&rows=100&sort=id&order=asc", function(data) {
            typeDomain = data;
        });
        tbTutorDataGrid = $('#tbTutorDataGrid').datagrid({
        url : '${path}/tbTutor/dataGrid',
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

        }, {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true
        }, {
            width : '60',
            title : '排序值',
            field : 'sortValue',
            sortable : true
        }, {
            width : '60',
            title : '姓名',
            field : 'name',
            sortable : true
        }, {
            width : '60',
            title : '头像',
            field : 'headImg',
            sortable : true,
            formatter :  function(value, row, index) {
                var str = '';
                str += $.formatString('<img src="{0}" height="30" width="55"></img>', row.headImg);
                return str;
            }
        },{
            width : '60',
            title : '公司',
            field : 'company',
            sortable : true
        }, {
            width : '60',
            title : '职位',
            field : 'position',
            sortable : true
        },  {
            width : '60',
            title : '常住地',
            field : 'permanentLand',
            sortable : true
        },{
            width : '60',
            title : '简短简介',
            field : 'shortIntro',
            sortable : true
        },{
            width : '60',
            title : '简介',
            field : 'intro',
            sortable : true
        }, {
            width : '60',
            title : '是否大咖',
            field : 'isMaster',
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
            title : '是否首页展示',
            field : 'isHomeDisplay',
            sortable : true,
            formatter : function(value, row, index) {
                switch (value) {
                    case 0:
                        return '是';
                    case 1:
                        return '否';
                }
            }
        },  {
            width : '60',
            title : '领域类型',
            field : 'domainType',
            sortable : true,
            formatter :  function(value, row, index) {
                var str = '';
                if(row.domainType!=null){
                    var domainTypes = row.domainType.split(",");

                    $.each($.parseJSON(typeDomain), function (index, obj) {
                        $.each(domainTypes,function (index,id) {
                            if(obj.id==id){
                                str += obj.name+",";
                            }
                        })
                    });
                }
                if(str!=''){
                    str = str.substr(0,str.length-1);
                }
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
                <shiro:hasPermission name="/tbTutor/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="tbTutor-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="tbTutorEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/tbTutor/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="tbTutor-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="tbTutorDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.tbTutor-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.tbTutor-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#tbTutorToolbar'
    });
        $('.typeDomain').combobox({
            formatter:function(row){
                return '<option value="'+row.id+'">'+row.name+'</option>';
            }
        });
});

/**
 * 添加框
 * @param url
 */
function tbTutorAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 600,
        href : '${path}/tbTutor/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbTutorDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbTutorAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function tbTutorEditFun(id) {
    if (id == undefined) {
        var rows = tbTutorDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        tbTutorDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 600,
        href :  '${path}/tbTutor/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = tbTutorDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#tbTutorEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function tbTutorDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = tbTutorDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         tbTutorDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
         if (b) {
             progressLoad();
             $.post('${path}/tbTutor/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     tbTutorDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}
/**
 * 批量删除
 */
function tbTutorBatchDeleteFun() {

    var rows = tbTutorDataGrid.datagrid('getSelections');
    if(rows.length < 1){
        parent.$.messager.alert("提示消息","请选择要删除的记录！",'info');
        return;
    }
    parent.$.messager.confirm('询问', '您是否要删除当前所选导师？', function(b) {
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
            $.post('${path}/tbTutor/batchDelete', {
                strIds : strIds
            }, function(result) {
                if (result.success) {
                    parent.$.messager.alert('提示', result.msg, 'info');
                    tbTutorDataGrid.datagrid('reload');
                }
                progressClose();
            }, 'JSON');
        }
    });
}
/**
 * 清除
 */
function tbTutorCleanFun() {
    $('#tbTutorSearchForm input').val('');
    tbTutorDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function tbTutorSearchFun() {
     tbTutorDataGrid.datagrid('load', $.serializeObject($('#tbTutorSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="tbTutorSearchForm">
            <table>
                <tr>
                    <th>模糊查询:</th>
                    <td><input name="q" placeholder="搜索条件"/></td>
                    <th>是否大咖:</th>
                    <td><select  name="isMaster">
                        <option></option>
                        <option value="0">是</option>
                        <option value="1">否</option>
                    </select></td>
                    <th>是否首页展示:</th>
                    <td><select  name="isHomeDisplay">
                        <option></option>
                        <option value="0">是</option>
                        <option value="1">否</option>
                    </select></td>
                    <th>领域类型:</th>
                    <td><input class="typeDomain" name="domainTypes" style="width: 100px"
                               url="tbTypeDomain/dataAll?page=1&rows=100&sort=id&order=asc" valueField="id" textField="name"／></td>
                    <td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="tbTutorSearchFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="tbTutorCleanFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="tbTutorDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="tbTutorToolbar" style="display: none;">
    <shiro:hasPermission name="/tbTutor/add">
        <a onclick="tbTutorAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/tbTutor/delete">
        <a onclick="tbTutorBatchDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-delete'">批量删除</a>
    </shiro:hasPermission>
</div>