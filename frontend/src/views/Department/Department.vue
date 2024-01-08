<template>
    <el-card shadow="never" class="index">
        <template #header>
            <div class="card_header">
                <b>部门</b>
                <div>
                    <el-button color="#3388BB" @click="addDialogFormVisible = true">增加</el-button>
                    <el-button color="#3388BB" @click="searchDialogFormVisible = true">搜索</el-button>
                     <el-button color="#3388BB" @click="preSelect()">筛选</el-button>
                      <el-button class="vice_button" @click="toggleTable()">{{ showTable ? '隐藏操作历史' : '显示操作历史' }}</el-button>
                </div>
            </div>
        </template>
        <!-- <el-empty description="暂无数据"></el-empty> -->

        <el-table  :data="tableData" stripe style="width: 100%">
            <el-table-column prop="depart_no" label="部门号"></el-table-column>
            <el-table-column prop="id" label="管理者员工号"></el-table-column>
            <el-table-column prop="bank_name" label="支行名称"></el-table-column>
            <el-table-column label="部门名称">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.depart_name"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.depart_name }}</p>
                </template>
            </el-table-column>
            <el-table-column label="部门类型">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.depart_type"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.depart_type }}</p>
                </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width=300px>
                <template #default="scope">
                    <el-button @click="preEdit(scope.row)" type='primary' size="small">编辑</el-button>
                    <el-button @click="handleEdit(scope.row)" type='success' size="small">保存</el-button>
                    <el-button @click="handleDelete(scope.row)" type='danger' size="small">删除</el-button>
                </template>
            </el-table-column>
        </el-table>

        <div style="padding: 10px 0">
            <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize" :page-sizes="[2, 4, 10, 20]"
                layout="total, sizes, prev, pager, next, jumper" :total="count" @size-change="handleSizeChange"
                @current-change="handleCurrentChange" />
        </div>

    <el-table v-if="showTable" :data="logData" :default-sort="{ prop: 'operation_time', order: 'descending' }" stripe style="width: 100%">
      <!-- Regular columns -->
      <el-table-column prop="operation_time" label="操作时间"></el-table-column>
      <el-table-column prop="type" label="操作类型"></el-table-column>
      <el-table-column prop="id" label="ID"></el-table-column>
      <el-table-column prop="depart_no" label="部门号"></el-table-column>
      <!-- Add other regular columns as needed -->

      <!-- Expandable content -->
      <el-table-column label="详细信息" width="200">
        <template #default="scope">
          <el-button class="span_button" size="mini" @click="handleExpand(scope.row)" type="text">
            {{ expandedRows.includes(scope.row)? '收起' : '展开' }}
          </el-button>
          <el-collapse-transition>
           <div v-show="expandedRows.includes(scope.row)">
            <!-- Add detailed information here -->
            <p>depart name: {{ scope.row.depart_name }}</p>
            <p>pre depart name: {{ scope.row.pre_depart_name }}</p>
            <p>depart type: {{ scope.row.depart_type }}</p>
            <p>pre depart type: {{ scope.row.pre_depart_type }}</p>
            <!-- Add other detailed information as needed -->
          </div>
          </el-collapse-transition>
        </template>
      </el-table-column>
    </el-table>

        <el-dialog v-model="addDialogFormVisible" title="增加">
            <el-form :model="addForm">
                <el-form-item label="部门号" label-width=100px>
                    <el-input v-model="addForm.depart_no" autocomplete="off" />
                </el-form-item>
                <el-form-item label="支行名称" label-width=100px>
                    <el-input v-model="addForm.bank_name" autocomplete="off" />
                </el-form-item>
                <el-form-item label="部门名称" label-width=100px>
                    <el-input v-model="addForm.depart_name" autocomplete="off" />
                </el-form-item>
                <el-form-item label="部门类型" label-width=100px>
                    <el-input v-model="addForm.depart_type" autocomplete="off" />
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="addDialogFormVisible = false">取消</el-button>
                    <el-button color="#3388BB" type="primary" @click="handleAdd()">确定</el-button>
                </span>
            </template>
        </el-dialog>

        <el-dialog v-model="searchDialogFormVisible" title="搜索">
            <el-form :model="searchForm">
                <el-form-item label="部门号" label-width=100px>
                    <el-input v-model="searchForm.depart_no" autocomplete="off" />
                </el-form-item>
                <el-form-item label="部门名称" label-width=100px>
                    <el-input v-model="searchForm.depart_name" autocomplete="off" />
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="searchDialogFormVisible = false">取消</el-button>
                    <el-button color="#3388BB" type="primary" @click="handleSearch()">确定</el-button>
                </span>
            </template>
        </el-dialog>

        <el-dialog v-model="selectDialogFormVisible" title="筛选">
            <el-form :model="searchForm">
                 <el-form-item label="管理者员工号" label-width=100px>
                      <el-select v-model="searchForm.id" >
                        <el-option v-for="id in uniqueId" :key="id" :label="id" :value="id"></el-option>
                    </el-select>  
                </el-form-item>
                <el-form-item label="支行名称" label-width=100px>
                    <el-select v-model="searchForm.bank_name" >
                        <el-option v-for="bank_name in uniqueBankName" :key="bank_name" :label="bank_name" :value="bank_name"></el-option>
                    </el-select> 
                </el-form-item>
                 <el-form-item label="部门类型" label-width=100px>
                    <el-select v-model="searchForm.depart_type" >
                        <el-option v-for="depart_type in uniqueDepType" :key="depart_type" :label="depart_type" :value="depart_type"></el-option>
                    </el-select> 
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="cleanSelect()">重置</el-button>
                    <el-button color="#3388BB" type="primary" @click="handleSelect()">确定</el-button>
                </span>
            </template>
        </el-dialog>
    </el-card>
</template>

<script>
import { ref, onMounted ,onUnmounted} from "vue";
import request from "@/utils/axios";
import { reactive } from "vue";
import { ElMessage } from "element-plus";
import { eventBus } from '@/utils/eventBus.js';

const bank_name = ref('');
const handleUpdate =(data)=>{ bank_name.value=data;  }
eventBus.on('updateSearchForm', handleUpdate);
if(bank_name.value!=''){searchForm.bank_name=bank_name.value;} 


export default {
    
    setup() {
        const tableData = ref([]) ;
        const logData =ref([]); 
        const fullData = ref([]) ;
        const addDialogFormVisible = ref(false);
        const searchDialogFormVisible = ref(false);
        const selectDialogFormVisible =ref(false);
        const addForm = reactive({
            depart_no: "",
            id: "",
            bank_name: "",
            depart_name: "",
            depart_type: "",
        });
        const searchForm = reactive({
            depart_no: "",
            id: "",
            bank_name: "",
            depart_name: "",
            depart_type: "",
        });

        const logForm =reactive({
            operation_time:"",
            type:"",
            depart_no: "",
            id: "",
            bank_name: "",
            depart_name: "",
            pre_depart_name:"",
            depart_type: "",
            pre_depart_type:"",

        })
        const currentPage = ref(1);
        const pageSize = ref(2);
        const count = ref(0);
        const baseurl = "/department";
        const uniqueBankName = ref([]);
        const uniqueDepType = ref([]);
        const uniqueId =ref ([]);
        const expandedRows = ref([]);
        const showTable= ref([false]);
        const originalData =ref([]); 

      

       const loadLog =() =>{
           request({ url: baseurl + "/pagelog", method: "post" }).then(res => {
                if (res.data.code == 200) {
                    logData.value =res.data.data.data;
                    console.log(logData);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });

       }

        const preEdit = (data) =>{
          data.showmode = true;
          // Deep copy originalData
          originalData.value = JSON.parse(JSON.stringify(tableData.value.find(row => row.depart_no === data.depart_no)));
        
       }



        const load = () => {
            request({ url: baseurl + "/page", method: "post", params: { page: currentPage.value, size: pageSize.value }, data: searchForm }).then(res => {
                if (res.data.code == 200) {
                    tableData.value = res.data.data.data;
                    count.value = res.data.data.count;
               console.log(logData);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
        };


        const initData = () =>{
             request({ url: baseurl + "/page", method: "post", params: { page: 1, size: 1000 }, data: searchForm }).then(res => {
                if (res.data.code == 200) {
                    fullData.value =res.data.data.data;
                    console.log(fullData);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
        }
        

         onMounted(() => {
            initData();
            loadLog();
            if(bank_name.value!=''){searchForm.bank_name=bank_name.value;}  
            load();  
        });


        const handleEdit = (data) => {
            request.post(baseurl + "/edit", data).then(res => {
                load();
                if (res.data.code == 200) {

                    const updatedData = { ...data };
                    const propertyNames = ['id', 'depart_no', 'depart_type', 'depart_name', 'pre_depart_name', 'pre_depart_type'];
                
                    for (const propertyName of propertyNames) {
                        logForm[propertyName] = updatedData[propertyName];

                        // 如果是 pre_ 开头的属性，从 originalData 中取值
                        if (propertyName.startsWith('pre_')) {
                            const originalPropertyName = propertyName.replace('pre_', '');
                            logForm[propertyName] = originalData.value[originalPropertyName];
                        }
                    }

                    logForm.operation_time= new Date().toLocaleString();
                    logForm.type ="Edit";

                    handleAddLog();

                    ElMessage.success(res.data.message);

                } else {                   
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
            data.showmode = false;
            
        };

        const handleDelete = (data) => {

            request.post(baseurl + "/delete", data).then(res => {
                load();
                if (res.data.code == 200) {

                    for (const key in data) {
                        logForm[key] = data[key];
                    }

                    logForm.operation_time= new Date().toLocaleString();
                    logForm.type ="Delete";
                    handleAddLog();

                    ElMessage.success(res.data.message);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
        };

        const handleSizeChange = (number) => {
            pageSize.value = number;
            load();
        };

        const handleCurrentChange = (number) => {
            currentPage.value = number;
            load();
        };


        const handleAddLog = () =>{

             console.log(logForm);
             request.post(baseurl + "/addlog", logForm).then(res => {
                loadLog();
                if (res.data.code == 200) {
                    console.log(res.data.message);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
                 Object.keys(logForm).forEach(key => {
                        logForm[key] = "";
                });
                  Object.keys(addForm).forEach(key => {
                addForm[key] = "";
            });
                
            }).catch(err => {
                ElMessage.error(err);
            });
        }

        const handleAdd = () => {

            request.post(baseurl + "/add", addForm).then(res => {
                load();
                if (res.data.code == 200) {
                     for (const key in addForm) {
                        logForm[key] = addForm[key];
                    }


                    console.log("fuck");
                    console.log(logForm);
                    console.log(addForm);
                    logForm.operation_time= new Date().toLocaleString();
                    logForm.type ="Add";
                    handleAddLog();


                    ElMessage.success(res.data.message);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                    Object.keys(addForm).forEach(key => {
                        addForm[key] = "";
                    });
                }
            }).catch(err => {
                ElMessage.error(err);
                  Object.keys(addForm).forEach(key => {
                addForm[key] = "";
            });

            });
            addDialogFormVisible.value = false;
          
        };
        const preSelect =() =>{
            selectDialogFormVisible.value = true;
            uniqueBankName.value= Array.from(new Set(fullData._rawValue.map(item => item.bank_name)));
            uniqueId.value= Array.from(new Set(fullData._rawValue.map(item => item.id)));
            uniqueDepType.value=Array.from(new Set(fullData._rawValue.map(item => item.depart_type)));
       }

        //用于筛选
       const handleSelect =() =>{
            load ();
            selectDialogFormVisible.value = false;     
       }

       //重置筛选结果
       const cleanSelect =() =>{
            Object.keys(searchForm).forEach(key => {
                searchForm[key] = "";
            });
       }

        const handleSearch = () => {
            load();
            searchDialogFormVisible.value = false;
            Object.keys(searchForm).forEach(key => {
                searchForm[key] = "";
            });
        };

        onUnmounted(() => {
           bank_name.value='';
        });

       const handleExpand = (row) => {
      // 使用 ref 提供的 .value 属性来访问和修改值
      const index = expandedRows.value.indexOf(row);
      if (index === -1) {
        // 如果行不在数组中，添加它
        expandedRows.value.push(row);
      } else {
        // 如果行在数组中，从数组中移除它
        expandedRows.value.splice(index, 1);
      }
    };

    const toggleTable =() => {
      showTable.value = !showTable.value;
    };

        return {
            tableData,
            logData,
            addDialogFormVisible,
            searchDialogFormVisible,
            selectDialogFormVisible,
            addForm,
            searchForm,
            bank_name,
            currentPage,
            pageSize,
            count,
            uniqueBankName,
            uniqueDepType,
            uniqueId,
            expandedRows,
            showTable,
            handleEdit,
            handleDelete,
            handleSizeChange,
            handleCurrentChange,
            handleAdd,
            handleSearch,
            handleSelect,
            preSelect,
            cleanSelect,
            handleUpdate,
            handleExpand,
            toggleTable,
            preEdit
        };
    }
}
</script>

<style lang="scss" scoped>
.card_header {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.vice_button{
   color: #fff ;
   background-color: #77BBDD;
}

.vice_button:hover{
   color: #fff ;
   background-color: #88BBDD;
}

.span_button{
    color: #3388BB
}


</style>
