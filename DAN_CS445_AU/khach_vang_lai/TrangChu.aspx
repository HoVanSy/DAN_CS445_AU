<%@ Page Title="" Language="C#" MasterPageFile="~/khach_vang_lai/Header.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="DAN_CS445_AU.TrangChu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="py-4 flex items-center justify-between">
        <div class="w-1/4">
            <button class="bg-primary text-white font-bold py-3 px-6 rounded-md flex items-center gap-3 w-full justify-center">
                <span class="material-icons-outlined">menu</span>DANH MỤC SẢN PHẨM
            </button>
        </div>
        <div class="hidden lg:flex items-center gap-8 text-heading-light dark:text-heading-dark font-semibold">
            <a class="hover:text-primary" href="#">Trang chủ</a>
            <a class="hover:text-primary" href="#">Giới thiệu</a>
            <a class="hover:text-primary" href="#">Sản phẩm</a>
            <a class="hover:text-primary" href="#">Tin tức</a>
            <a class="hover:text-primary" href="#">Liên hệ</a>
        </div>
    </nav>
    <section class="grid grid-cols-1 lg:grid-cols-3 gap-6 my-6">
        <div class="lg:col-span-2 bg-surface-light dark:bg-surface-dark rounded-lg p-8 md:p-12 flex items-center bg-no-repeat bg-left-bottom" style="background-image: url('https://fruitio.monamedia.net/wp-content/uploads/2024/04/organic2-slider1.jpg');">
            <div>
                <p class="text-primary font-bold text-lg">Fresh &amp; Organic</p>
                <h1 class="text-4xl md:text-6xl font-bold text-heading-light dark:text-heading-dark mt-2 mb-4 leading-tight">Trang trại Thực phẩm<br/>tươi sạch &amp; 100% Hữu cơ</h1>
                <p class="text-text-light dark:text-text-dark mb-8">Sản phẩm được trồng tự nhiên dành cho bạn.</p>
                <a class="bg-primary text-white font-bold py-3 px-8 rounded-full hover:opacity-90 transition-opacity" href="#">Mua Ngay</a>
            </div>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-8 flex flex-col justify-center items-center text-center bg-no-repeat bg-bottom" style="background-image: url('https://fruitio.monamedia.net/wp-content/uploads/2024/04/organic22-banner-1.jpg'); background-size: contain;">
            <h2 class="text-3xl font-bold text-heading-light dark:text-heading-dark">30% SALE OFF</h2>
            <p class="text-text-light dark:text-text-dark mt-2 mb-4">Spring Peach Fruit</p>
            <a class="bg-white text-amber-900 font-bold py-3 px-8 rounded-full hover:opacity-90 transition-opacity" href="#">Mua Ngay</a>
        </div>
    </section>
    <section class="grid grid-cols-2 md:grid-cols-4 gap-6 my-12">
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 flex flex-col items-center text-center">
            <img alt="Fresh produce icon" class="h-16 w-16 mb-4" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDCm8E6mvbqBVDQdcSUwNq6KvrZja_tQPXXZjCxmndlT1Sz9K8VaL5tvtx_PSgtGWKEj20nJDmmoCz9fR6MZAJcb1JlQWN53jJj7rJLuxrjlEOSgvs1BPw0pXGUtbVEImUIhYFerYiFBj6GowCXoL8e-_OC-4cneVYzkHrHiCt6wegE_rARrHNawZIu0v-6gF49BWEtt7PxuCNXqtXGv3zh3tGx0sy0wvXA559U-vs3JCz2YX77mHiFlB4GwZ6_MX8QxXTBnsVEeglT"/>
            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark">Tươi sạch</h3>
            <p class="text-sm mt-1">Thu hoạch trong ngày, đảm bảo độ tươi ngon tự nhiên.</p>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 flex flex-col items-center text-center">
            <img alt="Organic icon" class="h-16 w-16 mb-4" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDO_xK_98i_gb4NszyYdR03UjVzYVvGN2IMMYB6cwgN9GYW3YBlAAl5z5vhS1F2pbQnAgq02i50jbLvQiOvZ3jPIc2fkkYcjsnvwsYR1NNxng4XVaCxLRJa-QaQbXGfuakn7Z2VStmHbdizQiC_BiWx_QXEJVpmgNavs9n-pmaOiFbUOU_qcVjQq5FH2gJz9RNpftPmSSP8lTKiKr_V78L1rXjnu2e1BK8Nal9rRHf5YYS8r0rxhRpRmzDgCoAmcKocw6IMdNrwcmtG"/>
            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark">Hữu cơ</h3>
            <p class="text-sm mt-1">Canh tác theo tiêu chuẩn hữu cơ, không hóa chất độc hại.</p>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 flex flex-col items-center text-center">
            <img alt="Quality leaf icon" class="h-16 w-16 mb-4" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAODO_vm7A63bdd2CJh2bODNHvfjsPk9cdfUBN4Sw4wrhYYDSkB3opE8z68Dyys_g8l8lat2op0TwvwhaFREXd7ruArwk7n7Pv3SvcAgXXsH97TaILoLNupavQet0gyUA39pr6MQUJYKrDQ90Boq4ReQ5NTUt1h3fsqTPIr47ld7ma1lw-GOO4XX6Kc32VFyINOsI50rP3LrxQnbylh9XSt_KCJezWFaHQHj03U6N7GV9FywFWtmoEsNWSGxxa1yjac4RzeaZzTcjqR"/>
            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark">Chất lượng</h3>
            <p class="text-sm mt-1">Kiểm duyệt nghiêm ngặt từ trang trại đến tay bạn.</p>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 flex flex-col items-center text-center">
            <img alt="Natural product icon" class="h-16 w-16 mb-4" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC7GRJQTcqdhyUQG7tSbz-28Z-BsVMNpzFuBsbmZesRk-ayQbMPMdVMNN3y482KpMt4PQx6xCFnN-GweVgmQH6GnMRfoEse2HbYoJOmPNwyzKwg5usMIpYqtfMyK_uD5H35DKLx7K7nhLIm8_pT7q5Lx8IPf_BER2oGQA6v7yL4l_HbuFTAuKVTszDNLcOWZ1jEWc7W2t-LlOOSAWFMhCcy8H2yHbI0mf8H_pRRw3X1KCcbGLB_1amjqi2BUysRInnQuLT4vJtO6ZVT"/>
            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark">Tự nhiên</h3>
            <p class="text-sm mt-1">Giữ trọn hương vị nguyên bản từ nông sản tự nhiên.</p>
        </div>
    </section>
</asp:Content>
