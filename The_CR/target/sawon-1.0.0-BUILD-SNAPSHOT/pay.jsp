<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script>

function requestPay(){
    var IMP = window.IMP; // ��������
    IMP.init('imp52724474'); // 'iamport' ��� �ο����� "������ �ĺ��ڵ�"�� ���
	var msg;
  //���� �ý����� �����Ű�� �Լ�
    IMP.request_pay({
    	/* 	INIpayTest */
    	pg : 'html5_inicis', //kakaopay
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(), //�ֹ���ȣ
        name : 'CR ȣ��',
        amount : ${param.price},
        buyer_email : 'allsilver94@naver.com',
        buyer_name : 'name',
        buyer_tel : 'tel'
      //  m_redirect_url : 'http://localhost:8081/The_Diner/reserveSuccess.jsp'
    }, function(rsp) {
        if ( rsp.success ) {
            //[1] �����ܿ��� �������� ��ȸ�� ���� jQuery ajax�� imp_uid �����ϱ�
            msg = '������ �Ϸ�Ǿ����ϴ�.';
                    msg += '\n����ID : ' + rsp.imp_uid;
                    msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
                    msg += '\���� �ݾ� : ' + rsp.paid_amount;
                    msg += 'ī�� ���ι�ȣ : ' + rsp.apply_num;
                    alert(msg);
            jQuery.ajax({
            	url: "insertRs.do", //open(method,url,async)
            	// url: "/payments/complete", //cross-domain error�� �߻����� �ʵ��� �������ּ���
                type: 'POST', //open method
                dataType: 'json', 
                data: { //���� ������ ��
                    imp_uid : rsp.imp_uid,
                    merchant_uid: rsp.merchant_uid,
                    rnum : ${param.rnum},
                    rname : "${param.rname}",
                    rtel : "${param.rtel}",
                    ckin : "${param.ckin}",
                    ckout : "${param.ckout}",
                    rmname : "${param.rmname}",
                    people : ${param.people},
                    price : ${param.price},
                    payYN : "Y",
                    id : "${param.id}"
                    //��Ÿ �ʿ��� �����Ͱ� ������ �߰� ����
                }
            }).done(function(data) {
                //[2] �������� REST API�� ��������Ȯ�� �� ���񽺷�ƾ�� �������� ���
                if ( everythings_fine ) {
                    msg = '������ �Ϸ�Ǿ����ϴ�.';
                    msg += '\n����ID : ' + rsp.imp_uid;
                    msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
                    msg += '\���� �ݾ� : ' + rsp.paid_amount;
                    msg += 'ī�� ���ι�ȣ : ' + rsp.apply_num;
                    
                    alert(msg);
                } else {
                    //[3] ���� ����� ������ ���� �ʾҽ��ϴ�.
                    //[4] ������ �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó���Ͽ����ϴ�.
                }
            });
            //������ �̵��� ������
            location.href='payend.jsp';
        } else {
            msg = '������ �����Ͽ����ϴ�.';
            msg += '�������� : ' + rsp.error_msg;
            //���н� �̵��� ������
            location.href="reserve/reserveStep2.jsp";
            alert(msg);
        }
    });

}

</script>
<body onload="requestPay();">
</body>
</html>