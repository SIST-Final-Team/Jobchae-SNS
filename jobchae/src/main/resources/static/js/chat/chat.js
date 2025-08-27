// Stomp 프로토콜 웹소켓 모듈 
window.WebSocketManager = (() => {
    let socket = null;
    let stompClient = null;
    let isConnectedFlag = false; // 연결 상태를 명시적으로 관리

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

            // <<< 하트비트 설정 추가 >>>
            // 30초 주기로 클라이언트와 서버가 서로의 생존 여부를 확인합니다.
            stompClient.heartbeat.outgoing = 30000; // ms 단위다!
            stompClient.heartbeat.incoming = 30000;

            // 디버그 메시지를 끄고 싶다면 주석 처리하거나 함수를 비워두세요.
            // stompClient.debug = function(str) {
            //     console.log('STOMP Debug: ' + str);
            // };

			// 웹소켓 연결
            stompClient.connect({}, function (frame) {
                console.log('websocket connected : ' + frame);
                isConnectedFlag = true;
				// 콜백 함수가 존재한다면 콜백함수로 수신 데이터 전달
                if (callback) {
					callback(frame);
				}
            });

            // 소켓 연결이 어떤 이유로든(하트비트 실패 포함) 끊겼을 때 호출
            socket.onclose = function() {
                console.log("WebSocket connection closed.");
                isConnectedFlag = false;

                alert("서버와의 연결이 끊겼습니다. 페이지를 새로고침하거나 다시 시도해주세요.");
            };
        },

		// 웹소켓 연결 해제 함수
        disconnect: function () {
            if (stompClient !== null) {
                stompClient.disconnect(() => console.log("websocket disconnected"));
                console.log("websocket disconnected");
                isConnectedFlag = false;
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

        // 세션 만료되면 메세지 받아서 세션 종료 해주려함
        subscribeSessionStatus: function (url, callback) {
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
            // stompClient.connected는 비정상 종료 시 즉시 false가 안될 수 있다
            return isConnectedFlag;
        }
    };
// 정의 즉시 실행	
})();