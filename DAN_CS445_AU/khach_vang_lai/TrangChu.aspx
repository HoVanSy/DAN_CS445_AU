<%@ Page Title="Trang chủ - MonaFruit" Language="C#" MasterPageFile="~/khach_vang_lai/Header.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="DAN_CS445_AU.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <nav class="py-4 flex items-center justify-between">
        <div class="w-1/4">
            <button class="bg-primary text-white font-bold py-3 px-6 rounded-md flex items-center gap-3 w-full justify-center hover:bg-green-600 transition">
                <span class="material-icons-outlined">menu</span>DANH MỤC SẢN PHẨM
            </button>
        </div>
        <div class="hidden lg:flex items-center gap-8 text-heading-light dark:text-heading-dark font-semibold">
            <a class="hover:text-primary transition" href="#">Trang chủ</a>
            <a class="hover:text-primary transition" href="#">Giới thiệu</a>
            <a class="hover:text-primary transition" href="#">Sản phẩm</a>
            <a class="hover:text-primary transition" href="#">Tin tức</a>
            <a class="hover:text-primary transition" href="#">Liên hệ</a>
        </div>
    </nav>

    <section class="grid grid-cols-1 lg:grid-cols-3 gap-6 my-6">
        <div class="lg:col-span-2 bg-surface-light dark:bg-surface-dark rounded-lg p-8 md:p-12 flex items-center bg-no-repeat bg-left-bottom bg-cover" style="background-image: url('https://fruitio.monamedia.net/wp-content/uploads/2024/04/organic2-slider1.jpg');">
            <div>
                <p class="text-primary font-bold text-lg">Fresh & Organic</p>
                <h1 class="text-4xl md:text-6xl font-bold text-heading-light dark:text-heading-dark mt-2 mb-4 leading-tight">Trang trại Thực phẩm<br/>tươi sạch & 100% Hữu cơ</h1>
                <p class="text-text-light dark:text-text-dark mb-8">Sản phẩm được trồng tự nhiên dành cho bạn.</p>
                <a class="bg-primary text-white font-bold py-3 px-8 rounded-full hover:bg-green-600 transition" href="#">Mua Ngay</a>
            </div>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-8 flex flex-col justify-center items-center text-center bg-no-repeat bg-bottom bg-cover" style="background-image: url('https://fruitio.monamedia.net/wp-content/uploads/2024/04/organic22-banner-1.jpg');">
            <h2 class="text-3xl font-bold text-heading-light dark:text-heading-dark">30% SALE OFF</h2>
            <p class="text-text-light dark:text-text-dark mt-2 mb-4">Spring Peach Fruit</p>
            <a class="bg-white text-amber-900 font-bold py-3 px-8 rounded-full hover:bg-gray-100 transition" href="#">Mua Ngay</a>
        </div>
    </section>

    <section class="grid grid-cols-2 md:grid-cols-4 gap-6 my-12">
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 flex flex-col items-center text-center hover:shadow-lg transition">
            <img alt="Fresh produce icon" class="h-16 w-16 mb-4" src="https://cdn-icons-png.flaticon.com/512/415/415733.png"/>
            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark">Tươi sạch</h3>
            <p class="text-sm mt-1 text-gray-500">Thu hoạch trong ngày</p>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 flex flex-col items-center text-center hover:shadow-lg transition">
            <img alt="Organic icon" class="h-16 w-16 mb-4" src="https://cdn-icons-png.flaticon.com/512/2645/2645935.png"/>
            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark">Hữu cơ</h3>
            <p class="text-sm mt-1 text-gray-500">100% Tiêu chuẩn hữu cơ</p>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 flex flex-col items-center text-center hover:shadow-lg transition">
            <img alt="Quality leaf icon" class="h-16 w-16 mb-4" src="https://cdn-icons-png.flaticon.com/512/2560/2560589.png"/>
            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark">Chất lượng</h3>
            <p class="text-sm mt-1 text-gray-500">Kiểm duyệt nghiêm ngặt</p>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 flex flex-col items-center text-center hover:shadow-lg transition">
            <img alt="Natural product icon" class="h-16 w-16 mb-4" src="https://cdn-icons-png.flaticon.com/512/7594/7594589.png"/>
            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark">Tự nhiên</h3>
            <p class="text-sm mt-1 text-gray-500">Hương vị nguyên bản</p>
        </div>
    </section>

    <section class="my-12">
        <div class="flex flex-col md:flex-row justify-between items-end mb-6 gap-4">
            <h2 class="text-2xl font-bold text-heading-light dark:text-heading-dark border-l-4 border-primary pl-3">Sản phẩm chất lượng</h2>
            <div class="flex gap-6 text-sm font-semibold text-gray-500">
                <a href="#" class="text-primary border-b-2 border-primary pb-1">Mới nhất</a>
                <a href="#" class="hover:text-primary transition pb-1">Bán chạy</a>
                <a href="#" class="hover:text-primary transition pb-1">Khuyến mãi</a>
            </div>
        </div>

        <div class="lg:col-span-3 grid grid-cols-2 md:grid-cols-4 gap-6">
            
            <asp:Repeater ID="rptSanPham" runat="server">
                <ItemTemplate>
                    <div class="bg-white dark:bg-surface-dark rounded-lg p-4 shadow-sm border border-gray-100 dark:border-gray-800 hover:shadow-md transition group relative">
                        
                        <%-- Logic hiển thị nhãn giảm giá --%>
                        <%# Convert.ToInt32(Eval("PhanTramGiam")) > 0 ? 
                            "<span class='absolute top-2 left-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded'>-" + Eval("PhanTramGiam") + "%</span>" 
                            : "" %>

                        <div class="h-40 flex items-center justify-center mb-4">
                            <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TieuDe") %>' class="h-full object-contain group-hover:scale-110 transition duration-300">
                        </div>
                        
                        <div class="text-center">
                            <h3 class="font-bold text-gray-800 dark:text-white mb-1 hover:text-primary cursor-pointer truncate">
                                <%# Eval("TieuDe") %>
                            </h3>
                            
                            <p class="text-primary font-bold">
                                <%# string.Format("{0:N0}₫", Eval("Giá")) %>
                            </p>

                            <a href='ChiTietSanPham.aspx?id=<%# Eval("sp_id") %>' class="mt-2 inline-block text-xs text-gray-500 hover:text-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </section>

    <section class="bg-blue-50 dark:bg-gray-800 rounded-lg p-8 my-12 flex flex-col md:flex-row items-center justify-between bg-cover bg-center" style="background-image: linear-gradient(to right, #eef2ff, #ffffff00), url('https://img.freepik.com/free-photo/flat-lay-composition-fresh-vegetables_23-2148574936.jpg');">
        <div class="md:w-1/2 text-center md:text-left">
            <p class="text-red-500 font-bold mb-2">20% OFF</p>
            <h2 class="text-4xl font-bold text-blue-900 dark:text-white mb-4">Rau quả hữu cơ</h2>
            <button class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-6 rounded-full transition">Mua Ngay</button>
        </div>
        <div class="md:w-1/2"></div>
    </section>

    <section class="my-12">
        <div class="flex justify-between items-end mb-6">
            <h2 class="text-2xl font-bold text-heading-light dark:text-heading-dark border-l-4 border-gray-800 dark:border-white pl-3">Bán chạy</h2>
            <div class="flex gap-4 text-sm text-gray-500">
                 <a href="#" class="hover:text-primary transition">Trái cây</a>
                 <a href="#" class="hover:text-primary transition">Rau củ</a>
            </div>
        </div>
        <div class="lg:col-span-3 grid grid-cols-2 md:grid-cols-4 gap-6">
    
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <div class="bg-white dark:bg-surface-dark rounded-lg p-4 shadow-sm border border-gray-100 dark:border-gray-800 hover:shadow-md transition group relative">
                        
                         <%# Convert.ToInt32(Eval("PhanTramGiam")) > 0 ? 
                            "<span class='absolute top-2 left-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded'>-" + Eval("PhanTramGiam") + "%</span>" 
                            : "" %>

                        <div class="h-40 flex items-center justify-center mb-4">
                            <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TieuDe") %>' class="h-full object-contain group-hover:scale-110 transition duration-300">
                        </div>
                        
                        <div class="text-center">
                            <h3 class="font-bold text-gray-800 dark:text-white mb-1 hover:text-primary cursor-pointer truncate">
                                <%# Eval("TieuDe") %>
                            </h3>
                            
                            <p class="text-primary font-bold">
                                <%# string.Format("{0:N0}₫", Eval("Giá")) %>
                            </p>

                            <a href='ChiTietSanPham.aspx?id=<%# Eval("sp_id") %>' class="mt-2 inline-block text-xs text-gray-500 hover:text-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </section>

</asp:Content>