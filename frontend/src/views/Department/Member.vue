<template>
    <el-card shadow="never" class="index">
        <template #header>
            <div class="card_header">
                <b>员工</b>
                <div>
                    <el-button color="#3388BB" @click="addDialogFormVisible = true">增加</el-button>
                    <el-button color="#3388BB" @click="searchDialogFormVisible = true">搜索</el-button>
                    <el-button color="#3388BB" @click="preSelect()">筛选</el-button>
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
                    <el-button @click="scope.row.showmode = true" type='primary' size="small">编辑</el-button>
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
import { ref, onMounted,onBeforeUnmount,onBeforeMount} from "vue";
import request from "@/utils/axios";
import { reactive } from "vue";
import { ElMessage } from "element-plus";
import { eventBus } from '@/utils/eventBus.js';

const bank_name =ref('');


export default {
    setup() {
        const tableData = ref([]);
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
        const editForm = reactive({
            id: "",
            depart_no: "",
            depart_no_new: "",
            dep_depart_no: "",
            dep_depart_no_new: "",
            bank_name: "",
            bank_name_new: "",
            name_new: "",
            phone_new: "",
            address_new: "",
            salary: "",
            salary_new: "",
            level: "",
            level_new: "",
        });
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

      
       const handleUpdate =(data)=>{
            bank_name.value=data;     
        }

        onBeforeMount(async()=>{
         eventBus.on('updateSearchForm', handleUpdate);
         if(bank_name.value!=null){searchForm.bank_name=bank_name.value;}
        });

         onMounted(async() => {
            initData();
            if(bank_name.value!=null){searchForm.bank_name=bank_name.value;}
            load();
        });
        
    
         

        const handleEdit = (data) => {
            request.post(baseurl + "/edit", data).then(res => {
                load();
                if (res.data.code == 200) {
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

        const handleAdd = () => {
            request.post(baseurl + "/add", addForm).then(res => {
                load();
                if (res.data.code == 200) {
                    ElMessage.success(res.data.message);
                } else {
                    ElMessage.error(res.data.code + "：" + res.data.message);
                }
            }).catch(err => {
                ElMessage.error(err);
            });
            addDialogFormVisible.value = false;
            Object.keys(addForm).forEach(key => {
                addForm[key] = "";
            });
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
        return {
            tableData,
            addDialogFormVisible,
            searchDialogFormVisible,
            selectDialogFormVisible,
            addForm,
            searchForm,
            editForm,
            currentPage,
            pageSize,
            count,
            uniqueBankName,
            uniqueDDepNo,
            uniqueDepNo,
            uniqueLevel,
            uniqueSex,
            handleEdit,
            handleDelete,
            handleSizeChange,
            handleCurrentChange,
            handleAdd,
            handleSearch,
            handleSelect,
            preSelect,
            cleanSelect,
            handleUpdate
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
</style>
