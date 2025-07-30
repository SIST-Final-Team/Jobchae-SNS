// Stomp 프로토콜 웹소켓 모듈 
window.WebSocketManager = (() => {
    let socket = null;
    let stompClient = null;

    return {
		// 웹소켓 연결 함수 (주소, 콜백함수)
        connect: function (url, callback) {
			
			// 생성된 웹소켓이 존재하는지 확인
            if (stompClient && stompClient.connected) {
                console.log("already connected");
                return;
            }

            socket = new SockJS(url);
            stompClient = Stomp.over(socket);

			// 웹소켓 연결
            stompClient.connect({}, function (frame) {
                console.log('websocket connected : ' + frame);
				// 콜백 함수가 존재한다면 콜백함수로 수신 데이터 전달
                if (callback) {
					callback(frame);
				}
            });
        },

		// 웹소켓 연결 해제 함수
        disconnect: function () {
            if (stompClient !== null) {
                stompClient.disconnect(() => console.log("websocket disconnected"));
				// 자원 해제
                socket = null;
                stompClient = null;
            }
        },

		// 채팅 메시지 전송 함수 (전송 주소, 데이터)
        send: function (url, message) {
            if (stompClient && stompClient.connected) {
                stompClient.send(url, {}, JSON.stringify(message));
            }
            else {
                console.log("websocket not connected");
            }
        },
		
		// 채팅 읽음 상태 전송 함수 (전송 주소, 데이터)
		sendReadStatus: function (url, message) {
		    if (stompClient && stompClient.connected) {
		        stompClient.send(url, {}, JSON.stringify(message));
		    }
		    else {
		        console.log("websocket not connected");
		    }
		},

		// 채팅방을 기준으로 메시지 구독 요청 (구독 주소, 콜백 함수)
        subscribeMessage: function (url, callback) {
            if (stompClient && stompClient.connected) {
				// 구독 대상에게 수신 메시지가 들어오면 JSON 객체로 변경 후 콜백함수로 전달
                stompClient.subscribe(url, function (message) {
                    callback(JSON.parse(message.body));
                });
            }
            else {
                console.log("websocket not connected");
            }
        },

		// 채팅방을 기준으로 읽음 상태 구독 요청 (구독 주소, 콜백 함수)
		subscribeReadStatus: function (url, callback) {
		    if (stompClient && stompClient.connected) {
				// 구독 대상에게 수신 메시지가 들어오면 JSON 객체로 변경 후 콜백함수로 전달
		        stompClient.subscribe(url, function (message) {
		            callback(JSON.parse(message.body));
		        });
		    }
		    else {
		        console.log("websocket not connected");
		    }
		},

		// 웹소켓으로 이미 연결되었는지 확인하는 함수
        isConnected: function () {
            return stompClient && stompClient.connected;
        }
    };
// 정의 즉시 실행	
})();