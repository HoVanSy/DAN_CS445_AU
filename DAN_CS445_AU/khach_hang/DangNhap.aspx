<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="DAN_CS445_AU.khach_hang.DangNhap" %>

<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Đăng nhập - MonaFruit</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet"/>
<script>
    tailwind.config = {
      darkMode: "class",
      theme: {
        extend: {
          colors: {
            primary: "#22C55E", // Green-500
            "background-light": "#F9FAFB", // Gray-50
            "background-dark": "#111827", // Gray-900
          },
          fontFamily: {
            display: ["Poppins", "sans-serif"],
          },
          borderRadius: {
            DEFAULT: "0.5rem", // 8px
          },
        },
      },
    };
</script>
<style>
    body {
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }
  </style>
</head>
<body class="font-display bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 antialiased">
<div class="min-h-screen flex items-center justify-center p-4">
<div class="w-full max-w-sm">
<div class="text-center mb-8">
<div class="flex items-center justify-center mb-4">
<span class="material-icons-outlined text-4xl text-primary">eco</span>
<h1 class="text-3xl font-bold ml-2 text-gray-900 dark:text-white">MonaFruit</h1>
</div>
<h2 class="text-xl text-gray-600 dark:text-gray-400">Chào mừng trở lại! Vui lòng nhập thông tin của bạn.</h2>
</div>
<div class="bg-white dark:bg-gray-800 p-8 rounded-lg shadow-md">
<!-- BẮT ĐẦU FORM -->
<form id="form1" runat="server" class="space-y-6">
    
    <!-- 1. Email / Tên đăng nhập -->
    <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300" for="txtEmail">Email hoặc Tên đăng nhập</label>
        <div class="mt-1 relative">
            <span class="material-icons-outlined absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 dark:text-gray-500">
                person_outline
            </span>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="block w-full pl-10 pr-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm placeholder-gray-400 dark:placeholder-gray-500 focus:outline-none focus:ring-primary focus:border-primary sm:text-sm bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-gray-100" placeholder="ban@email.com"></asp:TextBox>
        </div>
    </div>

    <!-- 2. Mật khẩu -->
    <div>
        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300" for="txtMatKhau">Mật khẩu</label>
        <div class="mt-1 relative">
            <span class="material-icons-outlined absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 dark:text-gray-500">
                lock_outline
            </span>
            <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="block w-full pl-10 pr-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm placeholder-gray-400 dark:placeholder-gray-500 focus:outline-none focus:ring-primary focus:border-primary sm:text-sm bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-gray-100" placeholder="••••••••"></asp:TextBox>
        </div>
    </div>

    <!-- 3. Ghi nhớ & Quên mật khẩu -->
    <div class="flex items-center justify-between">
        <div class="flex items-center">
            <asp:CheckBox ID="chkGhiNho" runat="server" CssClass="h-4 w-4 text-primary focus:ring-primary border-gray-300 dark:border-gray-600 dark:bg-gray-700 rounded" />
            <label class="ml-2 block text-sm text-gray-900 dark:text-gray-300" for="chkGhiNho">Ghi nhớ tôi</label>
        </div>
        <div class="text-sm">
            <a class="font-medium text-primary hover:text-green-600 dark:hover:text-green-400" href="#">Quên mật khẩu?</a>
        </div>
    </div>

    <!-- 4. Nút Đăng nhập -->
    <div>
        <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" OnClick="btnDangNhap_Click" CssClass="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-background-light dark:focus:ring-offset-background-dark focus:ring-primary transition-colors duration-200 cursor-pointer" />
    </div>

    <!-- Thông báo lỗi -->
    <asp:Label ID="lblLoi" runat="server" Text="" CssClass="text-red-500 text-sm text-center block mt-2"></asp:Label>

</form>
<!-- KẾT THÚC FORM -->
<div class="mt-6">
<div class="relative">
<div class="absolute inset-0 flex items-center">
<div class="w-full border-t border-gray-300 dark:border-gray-600"></div>
</div>
<div class="relative flex justify-center text-sm">
<span class="px-2 bg-white dark:bg-gray-800 text-gray-500 dark:text-gray-400">Hoặc tiếp tục với</span>
</div>
</div>
<div class="mt-6 grid grid-cols-2 gap-3">
<div>
<a class="w-full inline-flex justify-center py-2 px-4 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm bg-white dark:bg-gray-700 text-sm font-medium text-gray-500 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors duration-200" href="#">
<span class="sr-only">Đăng nhập với Google</span>
<svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
<path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"></path><path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"></path><path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05"></path><path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"></path><path d="M1 1h22v22H1z" fill="none"></path>
</svg>
</a>
</div>
<div>
<a class="w-full inline-flex justify-center py-2 px-4 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm bg-white dark:bg-gray-700 text-sm font-medium text-gray-500 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors duration-200" href="#">
<span class="sr-only">Đăng nhập với Facebook</span>
<svg aria-hidden="true" class="w-5 h-5" fill="#1877F2" viewBox="0 0 24 24">
<path d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z"></path>
</svg>
</a>
</div>
</div>
</div>
</div>
<p class="mt-8 text-center text-sm text-gray-600 dark:text-gray-400">
        Bạn chưa có tài khoản?
        <a class="font-medium text-primary hover:text-green-600 dark:hover:text-green-400" href="#">
          Đăng ký ngay
        </a>
</p>
</div>
</div>
</body></html>
