<template>
    <el-card shadow="never" class="index">
        <template #header>
            <div class="card_header">
                <b>员工</b>
                <div>
                    <el-button color="#3388BB" @click="addDialogFormVisible = true">增加</el-button>
                    <el-button color="#3388BB" @click="searchDialogFormVisible = true">搜索</el-button>
                    <el-button color="#3388BB" @click="preSelect()">筛选</el-button>
                      <el-button class="vice_button" @click="toggleTable()">{{ showTable ? '隐藏操作历史' : '显示操作历史' }}</el-button>
                </div>
            </div>
        </template>
        <!-- <el-empty description="暂无数据"></el-empty> -->

        <el-table :data="tableData" stripe style="width: 100%">
            <el-table-column prop="id" label="员工号"></el-table-column>
            <el-table-column label="管理部门号" width="100">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.depart_no"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.depart_no }}</p>
                </template>
            </el-table-column>
            <el-table-column label="所属部门号" width="100">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.dep_depart_no"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.dep_depart_no }}</p>
                </template>
            </el-table-column>
            <el-table-column label="所属支行">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.bank_name"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.bank_name }}</p>
                </template>
            </el-table-column>
            <el-table-column label="员工姓名">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.name"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.name }}</p>
                </template>
            </el-table-column>
            <el-table-column prop="sex" label="员工性别"></el-table-column>
            <el-table-column prop="person_id" label="身份证号" width="200"></el-table-column>
            <el-table-column label="手机号" width="200">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.phone"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.phone }}</p>
                </template>
            </el-table-column>
            <el-table-column label="住址" width="200">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.address"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.address }}</p>
                </template>
            </el-table-column>
            <el-table-column label="工资">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.salary"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.salary }}</p>
                </template>
            </el-table-column>
            <el-table-column prop="begin_date" label="入职时间" width="200"></el-table-column>
            <el-table-column label="等级">
                <template #default="scope">
                    <el-input v-show="scope.row.showmode" v-model="scope.row.level"></el-input>
                    <p v-show="!scope.row.showmode">{{ scope.row.level }}</p>
                </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width="200">
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
      <el-table-column prop="sex" label="性别"></el-table-column>
      <el-table-column prop="person_id" label="身份证号"></el-table-column>
      <el-table-column prop="begin_date" label="入职时间"></el-table-column>
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
            <p>depart no: {{ scope.row.depart_no }}</p>
            <p>pre depart no: {{ scope.row.pre_depart_no }}</p>
            <p>dep depart no: {{ scope.row.dep_depart_no }}</p>
            <p>pre dep depart no: {{ scope.row.pre_dep_depart_no }}</p>
            <p>bank name: {{ scope.row.bank_name }}</p>
            <p>pre bank name: {{ scope.row.pre_bank_name }}</p>
            <p>name: {{ scope.row.name }}</p>
            <p>pre name: {{ scope.row.pre_name }}</p>
            <p>phone: {{ scope.row.phone }}</p>
            <p>pre phone: {{ scope.row.pre_phone }}</p>
            <p>address: {{ scope.row.address }}</p>
            <p>pre address: {{ scope.row.pre_address }}</p>
            <p>salary: {{ scope.row.salary }}</p>
            <p>pre salary: {{ scope.row.pre_salary }}</p>
            <p>level: {{ scope.row.level }}</p>
            <p>pre level: {{ scope.row.pre_level }}</p>
            <!-- Add other detailed information as needed -->
          </div>
          </el-collapse-transition>
        </template>
      </el-table-column>
    </el-table>


        <el-dialog v-model="addDialogFormVisible" title="增加">
            <el-form :model="addForm">
                <el-form-item label="所属部门号" label-width=100px>
                    <el-input v-model="addForm.dep_depart_no" autocomplete="off" />
                </el-form-item>
                <el-form-item label="支行名称" label-width=100px>
                    <el-input v-model="addForm.bank_name" autocomplete="off" />
                </el-form-item>
                <el-form-item label="员工姓名" label-width=100px>
                    <el-input v-model="addForm.name" autocomplete="off" />
                </el-form-item>
                <el-form-item label="员工性别" label-width=100px>
                    <el-input v-model="addForm.sex" autocomplete="off" />
                </el-form-item>
                <el-form-item label="身份证号" label-width=100px>
                    <el-input v-model="addForm.person_id" autocomplete="off" />
                </el-form-item>
                <el-form-item label="手机号" label-width=100px>
                    <el-input v-model="addForm.phone" autocomplete="off" />
                </el-form-item>
                <el-form-item label="住址" label-width=100px>
                    <el-input v-model="addForm.address" autocomplete="off" />
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
                <el-form-item label="员工号" label-width=100px>
                    <el-input v-model="searchForm.id" autocomplete="off" />
                </el-form-item>
                <el-form-item label="员工姓名" label-width=100px>
                    <el-input v-model="searchForm.name" autocomplete="off" />
                </el-form-item>
                <el-form-item label="身份证号" label-width=100px>
                    <el-input v-model="searchForm.person_id" autocomplete="off" />
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
                <el-form-item label="管理部门号" label-width=100px>
                     <el-select v-model="searchForm.depart_no" >
                        <el-option v-for="depart_no in uniqueDepNo" :key="depart_no" :label="depart_no" :value="depart_no"></el-option>
                    </el-select>  
                </el-form-item>
                <el-form-item label="所属部门号" label-width=100px>
                     <el-select v-model="searchForm.dep_depart_no" >
                        <el-option v-for="dep_depart_no in uniqueDDepNo" :key="dep_depart_no" :label="dep_depart_no" :value="dep_depart_no"></el-option>
                    </el-select>  
                </el-form-item>
                <el-form-item label="支行名称" label-width=100px>
                    <el-select v-model="searchForm.bank_name" >
                        <el-option v-for="bank_name in uniqueBankName" :key="bank_name" :label="bank_name" :value="bank_name"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="员工性别" label-width=100px>
                    <el-select v-model="searchForm.sex" >
                        <el-option v-for="sex in uniqueSex" :key="sex" :label="sex" :value="sex"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="等级" label-width=100px>
                    <el-select v-model="searchForm.level" >
                        <el-option v-for="level in uniqueLevel" :key="level" :label="level" :value="level"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button  @click="cleanSelect()">重置</el-button>
                    <el-button color="#3388BB" type="primary" @click="handleSelect()">确定</el-button>
                </span>
            </template>
        </el-dialog>
    </el-card>
</template>

<script>
import { ref, onMounted,onBeforeUnmount} from "vue";
import request from "@/utils/axios";
import { reactive } from "vue";
import { ElMessage } from "element-plus";
import { eventBus } from '@/utils/eventBus.js';

const bank_name =ref('');
const handleUpdate =(data)=>{ bank_name.value=data;  }
eventBus.on('updateSearchForm', handleUpdate);
if(bank_name.value!=''){searchForm.bank_name=bank_name.value;}  


export default {
    setup() {
        const tableData = ref([]);
        const logData =ref([]);
        const fullData =ref([]);
        const addDialogFormVisible = ref(false);
        const searchDialogFormVisible = ref(false);
        const selectDialogFormVisible =ref(false);
        const addForm = reactive({
            id: "",
            depart_no: "",
            dep_depart_no: "",
            bank_name: "",
            name: "",
            sex: "",
            person_id: "",
            phone: "",
            address: "",
            salary: "",
            begin_date: "",
            level: "",
        });
        const searchForm = reactive({
            id: "",
            depart_no: "",
            dep_depart_no: "",
            bank_name: "",
            name: "",
            sex: "",
            person_id: "",
            phone: "",
            address: "",
            salary: "",
            begin_date: "",
            level: "",
        });
        
         const logForm =reactive({
            operation_time:"",
            type:"",
            id: "",
            sex: "",
            person_id: "",
            begin_date:"",
            depart_no: "",
            pre_depart_no: "",
            dep_depart_no: "",
            pre_dep_depart_no: "",
            bank_name: "",
            pre_bank_name: "",
            name:"",
            pre_name: "",
            phone: "",
            pre_phone:"",
            address: "",
            pre_address:"",
            salary: "",
            pre_salary: "",
            level: "",
            pre_level: "",
        
        })
        const currentPage = ref(1);
        const pageSize = ref(2);
        const count = ref(0);
        const baseurl = "/member";
        //用于筛选
        const uniqueDepNo =ref([]);
        const uniqueLevel =ref([]);
        const uniqueDDepNo =ref([]);
        const uniqueBankName =ref([]);
        const uniqueSex =ref([]);
        const expandedRows = ref([]);
        const showTable= ref([false]);
        const originalData =ref([]); 
        
        const loadLog =() =>{
           request({ url: baseurl + "/pagelog", method: "post" }).then(res => {
                if (res.data.code == 200) {
                    console.log("AAAA");
                    console.log(res);
                    logData.value =res.data.data.data;
                    console.log(logData);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });

       }

        const load = () => {
            request({ url: baseurl + "/page", method: "post", params: { page: currentPage.value, size: pageSize.value }, data: searchForm }).then(res => {
                if (res.data.code == 200) {
                    tableData.value = res.data.data.data;
                    count.value = res.data.data.count;
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
        };
        const initData = () =>{
             request({ url: baseurl + "/page", method: "post", params: { page: 1, size:1000 }, data: searchForm }).then(res => {
                if (res.data.code == 200) {
                    fullData.value =res.data.data.data;
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            
            });
        }


         onMounted(() => {
            loadLog();
            initData();
            if(bank_name.value!=''){searchForm.bank_name=bank_name.value;}  
            load();
        });
        
       const preEdit = (data) =>{
          data.showmode = true;
          // Deep copy originalData
          originalData.value = JSON.parse(JSON.stringify(tableData.value.find(row => row.id === data.id)));
       }
       const handleAddLog = () =>{
             console.log(logForm);
             console.log(logForm.begin_date);
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

        const handleEdit = (data) => {
            request.post(baseurl + "/edit", data).then(res => {
                load();
                if (res.data.code == 200) {
                    
                    const updatedData = { ...data };
                    const propertyNames = ['operation_time','type', 'id', 'sex','person_id','begin_date','depart_no','pre_depart_no','dep_depart_no','pre_dep_depart_no','bank_name','pre_bank_name','name',
                    'pre_name','phone','pre_phone','address','pre_address','salary','pre_salary','level','pre_level'];

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

        const getCurrentFormattedDate = () =>{
        const currentDate = new Date();
        const year = currentDate.getFullYear();
        const month = String(currentDate.getMonth() + 1).padStart(2, '0');
        const day = String(currentDate.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
        };
        const handleAdd = () => {
            request.post(baseurl + "/add", addForm).then(res => {
                load();
                if (res.data.code == 200) {
                    for (const key in addForm) {
                        logForm[key] = addForm[key];
                    }
                  
                    logForm.begin_date=getCurrentFormattedDate();
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
            uniqueDDepNo.value= Array.from(new Set(fullData._rawValue.map(item => item.dep_depart_no)));
            uniqueDepNo.value=Array.from(new Set(fullData._rawValue.map(item => item.depart_no)));
            uniqueLevel.value=Array.from(new Set(fullData._rawValue.map(item => item.level)));
            uniqueSex.value=Array.from(new Set(fullData._rawValue.map(item => item.sex)));
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

         onBeforeUnmount(() => {
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
            currentPage,
            pageSize,
            count,
            uniqueBankName,
            uniqueDDepNo,
            uniqueDepNo,
            uniqueLevel,
            uniqueSex,
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
            preEdit,
            handleExpand,
            toggleTable
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
