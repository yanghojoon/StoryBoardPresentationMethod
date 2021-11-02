# 스토리보드에서 View의 화면 전환 방식 확인

View의 화면 전환 방식에는 Modality와 Navigation이 있고 modal에서도 present modally를 선택하면 full screen, page sheet  등 다양한 방법이 존재한다. 

따라서 View LifeCycle에 중점을 두고 화면 전환 방식을 정리해보고자 해당 코드를 작성했다. 

해당 내용을 바탕으로 작성한 [블로그](https://ho8487.tistory.com/13)

## Present Modally의 Presentation 방법
### 1. Automatic
Automatic으로 설정하게 되면 이전 화면이 화면 상단에 살짝 보이는 형태로 화면이 전환된다. 

또한 따로 dismiss 버튼이 없더라도 화면을 아래로 스와이프하면 모달 창을 닫을 수 있다. 

그렇다면 View의 Life Cycle은 어떻게 진행될까?
일단 Simulator를 통해 실행을 하게 되면 오렌지 색의 첫번째 View가 나오면서 다음 LifeCycle까지 진행된다. 

`first init -> first loadView -> first viewDidLoad -> first viewWillAppear -> first viewDidAppear`

여기서 2번째 모달 View로 가는 버튼을 클릭하게 되면 다음과 같이 LifeCycle이 진행된다. 

`second init -> second loadView -> second viewDidLoad -> second viewWillAppear -> second viewDidAppear`

단 여기서 firstView의 경우 어떤 LifeCycle도 호출되지 않는다. 그 이유는 두 번째 모달 창이 뜨고 화면 상단에 약간이지만 첫 번째 모달 창이 보이고 있기 때문이다. 따라서 첫 번째 View에 대해 `viewWillDisappear`나 `viewDidDisappear`가 호출되지 않는다. 

그렇다면 Dismiss 버튼을 눌러서 한 번에 모달 창을 꺼버리면 어떻게 될까?

`second viewWillDisappear -> second viewDidDisappear -> second deinit`

이렇게 LifeCycle 메서드가 차례로 호출된다. 앞에서 viewWillDisappear과 viewDidDisappear이 호출되지 않았기 때문에 viewWillAppear과 viewDidAppear 또한 호출되지 않는다.

그렇다면 두 번째 View를 스와이프하다가 다시 올리면 어떻게 반응할까?

`second viewWillDisappear -> second viewWillAppear -> second viewDidAppear`

내리면 바로 viewWillDisappear가 호출되다가 다시 올리면 viewWillAppear과 viewDidAppear이 차례로 호출된다. 

#### 그렇다면 화면을 Landscape(가로모드)로 보면 어떤 차이가 있을까?
이렇게 하게 되면 화면이 Full Screen 형태로 모달 창이 보이게 된다. 또한 스와이프를 통한 화면 닫기 기능도 실행이 되지 않는다.

하지만 View의 LifeCycle 메서드는 동일하게 호출된다.
(여전히 첫번째 View의 viewWillDisappear과 viewDidDisappear은 호출되지 않는다)

따라서 이는 Full Screen 방식으로 presenatation이 되는 것은 아니지만 Over Full Screen 방식으로 전환되는 것이 아닐까 생각된다. 

### 2. Full Screen
Full Screen 방식으로 두 번째 View를 열게 되면 첫번째 View는 전혀 안보이고 화면이 꽉 차게 modal이 뜨게 된다. 
따라서 이 때는 반드시 Dismiss 버튼이 필요하다. 

그렇다면 Automatic으로 화면을 전환할 때와 어떤 차이가 있을까?

첫 번째 화면이 사용자에게 처음 보일 때까진 동일하다.

하지만 두 번째 View를 띄울 때 `viewWillDisappear`과 `ViewDidDisappear`이 호출된다. 
또한 두 번째 View를 닫을 때도 `viewWillAppear`과 `ViewDidAppear`이 호출된다. 

Full Screen 방식의 경우 가로모드일 때도 동일하게 메서드가 호출된다. 

### 3. Current Context
Current Context를 통해 전환을 할 때 View의 크기를 설정하지 않는다면 Full Screen과 동일하게 화면이 전환된다. 
메서드 또한 Full Screen과 동일하게 호출된다. 

하지만 ViewController를 통해 화면 크기를 설정해주면 그 크기대로 화면이 전환된다. (이는 추후 추가적으로 알아보도록 하자)

### 4. Page Sheet / Form Sheet
Page Sheet의 경우 Automatic과 동일하게 호출되고, Form Sheet의 경우 Page Sheet보단 작게 전환된다. 
하지만 호출되는 메서드의 경우 Automatic과 동일하다. 

### 5. Over Full Screen / Over Current Context
Full Screen과 동일하게 화면은 보이지만 호출되는 것은 다르다. 
호출되는 메서드의 경우 Automatic과 동일하게 호출된다. 

따라서 Automatic의 가로모드도 Full Screen이 아닌 Over Full Screen이 호출되는 것이 아닌가 생각했다. 

> Over가 붙는다면 Full Screen으로 화면은 보이지만 first ViewWillDisappear, first ViewDidDisappear, first ViewWillAppear, first ViewDidAppear이 호출되지 않는다. 
