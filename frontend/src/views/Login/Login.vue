<template>
    <div class="login">
        <el-card class="login_center">
            <template #header>
                <div class="card_header">
                    <span>用户登录</span>
                </div>
            </template>
            <el-form :model="loginFormState" :rules="rules" ref="loginFormRef">
                <el-form-item prop="name">
                    <el-input  v-model.trim="loginFormState.name" maxlength="32" placeholder="请输入账号" clearable>
                        <template #prefix>
                            <icons name="User"></icons>
                        </template>
                    </el-input>
                </el-form-item>
                <el-form-item prop="pwd">
                    <el-input  v-model.trim="loginFormState.pwd" maxlength="16" show-password placeholder="请输入密码" clearable
                        @keyup.enter.exact="handleLogin">
                        <template #prefix>
                            <icons name="Lock"></icons>
                        </template>
                    </el-input>
                </el-form-item>
                <el-form-item>
                    <el-button :disabled=" loginFormState.name==='' || loginFormState.pwd==='' " type="primary" style="width: 100%" :loading="loginFormState.loading" @click="handleLogin">登
                        录</el-button>
                </el-form-item>
            </el-form>
        </el-card>
    </div>
</template>

<script>
import { reactive, ref } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import Icons from "@/components/Icons.vue";
import request from "@/utils/axios";
import { ElMessage } from "element-plus";

export default {
   
    components: { Icons },
    setup() {
        const router = useRouter();
        const store = useStore();
        const loginFormState = reactive({
            name: "",
            pwd: "",
            loading: false,
        });

        const rules = {
            name: [{ required: true, message: "账号不能为空", trigger: "blur" }],
            pwd: [
                { required: true, message: "密码不能为空", trigger: "blur" },
                { min: 5, max: 16, message: "密码长度为5-16位", trigger: "blur" },
            ],
        };

        const loginFormRef = ref();

        const handleLogin = () => {
            loginFormRef.value.validate(valid => {
                if (!valid) {
                    return false;
                }

                loginFormState.loading = true;
                request.post("/user/login", { name: loginFormState.name, password: loginFormState.pwd }).then(res => {
                    if (res.data.code == 200) {
                        let params = { role: loginFormState.name === "admin" ? "admin" : "user", username: loginFormState.name };
                        sessionStorage.setItem("token", res.data.data);
                        sessionStorage.setItem("jwt", JSON.stringify(params));
                        store.dispatch("setUser", params);
                        ElMessage.success(res.data.message);
                        router.replace("/");
                    } else {
                       // ElMessage.error(res.data.code + "：" + res.data.message);
                       ElMessage.error("登录失败，请检查用户名和密码。");
                    }
                    loginFormState.loading = false;
                }).catch(err => {
                    ElMessage.error(err);
                    loginFormState.loading = false;
                });

            });
        };

        return { loginFormState, rules, loginFormRef, handleLogin };
    },
};
</script>

<style lang="scss" scoped>
.login {
    width: 100vw;
    height: 100vh;
    // background-image: url("../../assets/img/login.png");
    background-size: cover;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;

    .login_center {
        width: 300px;
        padding: 20px;
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 8px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
        transition: transform 0.3s ease-in-out; 

        &:hover {
            transform: scale(1.05);
        }

        .card_header {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
            font-weight: bold;
        }

        .el-input {
            width: 100%;
            height: 45px;    
            margin-bottom: 20px;
           
            &:hover {
                transform: scale(1.05);
            }
        }

        .el-button {
            width: 100%;
            height:45px;
            background-color: #0056b3; 
            border-color: #0056b3;
            color: #d8e1e8; 
            font-weight: bold;
            border-radius: 4px;
            font-size: 16px;
            transition: background-color 0.3s ease-in-out;
           
            &:disabled{
                background-color: #abadb0; 
                border-color: #abadb0;
                color: white;
            }
            &:not(:disabled):hover {
                background-color: #004080; 
                border-color: #004080;
                transform: scale(1.05);
            }
        }

        .el-alert {
            margin-top: 20px;
            border-radius: 4px;
            background-color: #ff3b30;
            color: #fff;
            border-color: #ff3b30;
        }
    }
}


</style>
