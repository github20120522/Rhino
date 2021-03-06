<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>用户管理</title>
    <%@ include file="../util/common.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {

            var ajaxParamsFn = function(){
                var params = {};
                params.name = $("#name").val();
                return params;
            };
            var columns = [{
                "data": "id"
            }, {
                "data": null,
                "className": 'details-control',
                "defaultContent": ''
            }, {
                "data": "name",
                className: "dtCenter"
            }, {
                "data": "realName",
                className: "dtCenter dtNoWrap"
            }, {
                "data": "isActivity",
                className: "dtCenter"
            }, {
                "data": "op"
            }];
            var columnDefs = [{
                "visible": false,
                "targets": [0]
            }, {
                "render": function ( data, type, row ) {
                    return data + ' (' + row.isActivity + ')';
                },
                "targets": 2
            }, {
                "targets": -1,
                "data": null,
                "defaultContent": "<button>点点点</button>"
            }];
            var tabParamsConfig = {
                url: "${basePath}dt/dtListJson",
                tabElement: "#example",
                exConfig: {
                    scrollY: 320
                },
                ajaxParamsFn: ajaxParamsFn,
                columns: columns,
                columnDefs: columnDefs,
                singleSelectFlag: false
            };
            var table = new commonDataTable(tabParamsConfig);

            // 自定义
            $('#example tbody').on('click', 'button', function () {
                var data = table.row($(this).parents('tr')).data();
                alert(data.name + data.realName);
            });

            // 获取选中元素的值
            $('#button').click(function () {
                console.log(table.rows('.selected').data());
            });

            // 重新查询
            $("#reloadBtn").click(function () {
                table.ajax.reload();
            });

            var keyList = [{
                label: '姓名',
                key: 'name'
            }, {
                label: '真实姓名',
                key: 'realName'
            }];
            // 记录明细展示
            bindRowDetailShow(table, "#example", keyList);

            $("#name").bind("keypress", function (event) {
                if (event.keyCode == 13) {
                    table.ajax.reload();
                }
            });

        });
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">用户列表</h3>
        </div>
        <div class="panel-body">
            <div class="form-group form-inline">
                <div class="row row-margin-bottom">
                    <div class="col-md-1">
                        <input id="button" class="btn btn-success btn-xs" type="button" value="获取选中数据">
                    </div>
                </div>
                <div class="row row-margin-bottom">
                    <div class="col-md-3">
                        <div class="input-group input-group-sm">
                            <span class="input-group-addon" id="basic-addon1">姓名</span>
                            <input id="name" type="text" class="form-control" aria-describedby="basic-addon1">
                        </div>
                        <input id="reloadBtn" class="btn btn-primary btn-sm" type="button" value="查询">
                    </div>
                </div>
            </div>
            <table id="example" class="dataTable compact display cell-border hover order-column row-border stripe" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>ID</th>
                    <th></th>
                    <th>姓名</th>
                    <th>真实姓名</th>
                    <th>是否有效</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
