function is_hangul_char(ch) {
     c = ch.charCodeAt(0);
     if( 0x1100<=c && c<=0x11FF ) return true;
     if( 0x3130<=c && c<=0x318F ) return true;
     if( 0xAC00<=c && c<=0xD7A3 ) return true;
     return false;
   }

var eng=[['`','1','2','3','4','5','6','7','8','9','0','-','=','←'],
         ['tab','q','w','e','r','t','y','u','i','o','p','[',']','\\'],
         ['caps lock','a','s','d','f','g','h','j','k','l','enter'],
         ['shift','z','x','c','v','b','n','m',',','.','/','한/영'],
         ['space']]
         
var shiftEng=[['~','!','@','#','$','%','^','&','*','(',')','_','+','←'],
   ['tab','Q','W','E','R','T','Y','U','I','O','P','{','}','|'],
   ['caps lock','A','S','D','F','G','H','J','K','L','enter'],
   ['shift','Z','X','C','V','B','N','M','<','>','?','한/영'],
   ['space']]

var kor=[['`','1','2','3','4','5','6','7','8','9','0','-','=','←'],
   ['tab','ㅂ','ㅈ','ㄷ','ㄱ','ㅅ','ㅛ','ㅕ','ㅑ','ㅐ','ㅔ','[',']','\\'],
   ['caps lock','ㅁ','ㄴ','ㅇ','ㄹ','ㅎ','ㅗ','ㅓ','ㅏ','ㅣ','enter'],
   ['shift','ㅋ','ㅌ','ㅊ','ㅍ','ㅠ','ㅜ','ㅡ',',','.','/','한/영'],
   ['space']]
   
var shiftKor=[['~','!','@','#','$','%','^','&','*','(',')','_','+','←'],
   ['tab','ㅃ','ㅉ','ㄸ','ㄲ','ㅆ','ㅛ','ㅕ','ㅑ','ㅒ','ㅖ','{','}','|'],
   ['caps lock','ㅁ','ㄴ','ㅇ','ㄹ','ㅎ','ㅗ','ㅓ','ㅏ','ㅣ','enter'],
   ['shift','ㅋ','ㅌ','ㅊ','ㅍ','ㅠ','ㅜ','ㅡ','<','>','?','한/영'],
   ['space']]
   
var 
   HANGUL_OFFSET = 0xAC00,
   COMPLETE_CHO = [
    'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ',
    'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ',
    'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
   ],
   COMPLETE_JUNG = [
    'ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ',
    'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ',
    'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ', 'ㅞ', 'ㅟ',
    'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ'
   ],
   COMPLETE_JONG = [
    '', 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ',
    'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ',
    'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
   ],
   COMPLEX_CONSONANTS = [
    ['ㄱ','ㅅ','ㄳ'],
    ['ㄴ','ㅈ','ㄵ'],
    ['ㄴ','ㅎ','ㄶ'],
    ['ㄹ','ㄱ','ㄺ'],
    ['ㄹ','ㅁ','ㄻ'],
    ['ㄹ','ㅂ','ㄼ'],
    ['ㄹ','ㅅ','ㄽ'],
    ['ㄹ','ㅌ','ㄾ'],
    ['ㄹ','ㅍ','ㄿ'],
    ['ㄹ','ㅎ','ㅀ'],
    ['ㅂ','ㅅ','ㅄ']
   ],
   COMPLEX_VOWELS = [
    ['ㅗ','ㅏ','ㅘ'],
    ['ㅗ','ㅐ','ㅙ'],
    ['ㅗ','ㅣ','ㅚ'],
    ['ㅜ','ㅓ','ㅝ'],
    ['ㅜ','ㅔ','ㅞ'],
    ['ㅜ','ㅣ','ㅟ'],
    ['ㅡ','ㅣ','ㅢ']
   ];
         
var ga = 44032;      


/* $j(document).on("focusout",".inputKeyboard",function(){
   var keyboard=$j("#keyboard");
   keyboard.empty();
});  */

// 키보드 생성====================================================================================================================================
$j(document).on("click",".inputKeyboard",function(){
   $j(this).focus();
   var keyboard=$j("#keyboard");
   
   var thisId = $j(this).attr('id');
   var parentId= $j(this).parent().parent().parent().parent().attr('id');
   keyboard.attr('name',parentId+','+thisId)
   keyboard.empty();
   show_keyboard(eng);
});

function change_keyboard(language,lanArr){
   var keyboard=$j("#keyboard");
   keyboard.empty();
   show_keyboard(lanArr);
   $j("#langu").attr("value",language);
}

function show_keyboard(obj){
   for(var i=0;i<obj.length;i++){
      var ul = document.createElement('ul');
      for(var j=0;j<obj[i].length;j++){
         var li = document.createElement('li');
         var key= document.createTextNode( obj[i][j] );
         li.appendChild( key );

         if( obj[i][j]=='enter'){
            li.style="width:208px";
         }else if(obj[i][j]=='한/영'){
            li.style="width:156px";
         }else if(obj[i][j]=='space'){
            li.style="width:735px";
         }
         ul.appendChild(li);
      }
      document.getElementById('keyboard').appendChild(ul);   
   }
}
var shiftCnt=0;
//가상키보드 클릭시 문자 입력====================================================================================================================================
$j(document).on("click","li",function(){
   
   var spt = $j(this).parent().parent().attr('name').split(',');
   var $area = $j("#"+spt[0]).find("#"+spt[1]);
   var input = $area.val();

   $area.focus();
   
   var text = $j(this).text();
   
   if(text=="space"){
      text =" ";
      $area.val(input + text);
      
   }else if(text=="tab"){
      text ="    ";
      $area.val(input + text);
      
   }else if(text=="한/영"){
      if($j("#langu").val()=="eng" || $j("#langu").val()=="shiftEng" ){
         change_keyboard('kor',kor);
      }else{
         change_keyboard('eng',eng);
      }

   }else if(text=="caps lock" ){
      if($j("#langu").val()=="eng"){
         change_keyboard('shiftEng',shiftEng);
      }else if($j("#langu").val()=="shiftEng"){
         change_keyboard('eng',eng);
      }
      
   }else if(text=="shift"){
      shiftCnt=1;
      
      if($j("#langu").val()=="eng"){
         change_keyboard('shiftEng',shiftEng);
      }else if($j("#langu").val()=="shiftEng"){
         change_keyboard('eng',eng);
      }else if($j("#langu").val()=="kor"){
         change_keyboard('shiftKor',shiftKor);
      }else if($j("#langu").val()=="shiftKor"){
         change_keyboard('kor',kor);
      }
      
   }else if(text=="←"){
      $area.val(input.slice(0,-1));
   }else if(text=="enter"){
      text="\n";
      $area.val(input + text);
      
      }else{ //특수키 제외 === 글자 입력
      var lastText = input.substring(input.length-1);
      var code= lastText.charCodeAt(0);

      loop:if(is_hangul_char(text)){//입력글자가 한글이라면
         
         if(is_hangul_char(lastText)){//마지막 문자가 한글이라면 
            if(0xAC00 <= code && code <= 0xd7a3){ //마지막문자가 조합이라면
               code = code-ga;
               var fn = parseInt(code / 588);  //초성인덱스
               var sn= parseInt((code - (fn * 588)) / 28);    // 중성 인덱스 
               var tn = parseInt(code % 28); //종성 인덱스
                  
               if(tn>0){ // 종성이 이미 있을때
                  if(COMPLETE_CHO.indexOf(text)>-1){ //자음
                     for(var i =0;i<COMPLEX_CONSONANTS.length;i++){// ㅂ+ㅅ= ㅄ
                        if(COMPLEX_CONSONANTS[i][0]==COMPLETE_JONG[tn] && COMPLEX_CONSONANTS[i][1]==text){
                           var newTn =COMPLETE_JONG.indexOf(COMPLEX_CONSONANTS[i][2]);
                              
                           text = String.fromCharCode( 0xAC00 + 21*28*fn + 28*sn+newTn);
                           $area.val(input.slice(0,-1) + text);
                           break loop;
                        }
                     }
                       // ㅂ+ㄱ=ㅂㄱ
                     $area.val(input + text);
                     
                  }else{//모음
                     for(var i =0;i<COMPLEX_CONSONANTS.length;i++){//값+ㅏ -> 갑사 
                        if(COMPLEX_CONSONANTS[i][2]==COMPLETE_JONG[tn]){
                           var newTn = COMPLETE_JONG.indexOf(COMPLEX_CONSONANTS[i][0]);
                             
                           var text1 = String.fromCharCode( 0xAC00 + 21*28*fn + 28*sn+newTn); //갑
                           
                           var newFn=COMPLETE_CHO.indexOf(COMPLEX_CONSONANTS[i][1]); 
                           var newSn=COMPLETE_JUNG.indexOf(text);
                               var text2= String.fromCharCode( 0xAC00 + 21*28*newFn + 28*newSn);//사

                               $area.val(input.slice(0,-1) + text1+text2);
                             break loop;
                          }
                     }
                       
                     //갑+ㅏ -> 가바
                       var text1 = String.fromCharCode( 0xAC00 + 21*28*fn + 28*sn);//가
                       
                       var newFn=COMPLETE_CHO.indexOf(COMPLETE_JONG[tn]);
                       var newSn=COMPLETE_JUNG.indexOf(text);
                       var text2 = String.fromCharCode( 0xAC00 + 21*28*newFn + 28*newSn);//바
                       
                       $area.val(input.slice(0,-1) + text1+text2);
                    
                    }
               }else{//종성이 없을때
                  if(COMPLETE_CHO.indexOf(text)>-1){ //자음
                     if(COMPLETE_JONG.indexOf(text)>-1){//가+ㅅ=갓 
                        var newTn=COMPLETE_JONG.indexOf(text);
                           text = String.fromCharCode( 0xAC00 + 21*28*fn + 28*sn +newTn);
                           $area.val(input.slice(0,-1) + text);
                     }else{//따+ㄸ=따ㄸ
                        $area.val(input + text);
                     }
                     
                     }else{//모음
                        for(var i =0;i<COMPLEX_VOWELS.length;i++){// 고+ㅏ=과 
                           if(COMPLEX_VOWELS[i][0]==COMPLETE_JUNG[sn] && COMPLEX_VOWELS[i][1]==text){
                              var newSn=COMPLETE_JUNG.indexOf( COMPLEX_VOWELS[i][2]);
                               text = String.fromCharCode( 0xAC00 + 21*28*fn + 28*newSn );
                               $area.val(input.slice(0,-1) + text);
                               break loop;
                           }
                        }
                        // 스+ㅓ=스ㅓ
                        $area.val(input + text);
                     }
               }
               
               
            }else{//단타라면
               if(COMPLETE_CHO.indexOf(text)>-1){ //자음
                  if(COMPLETE_CHO.indexOf(lastText)>-1){//자음+자음 
                     for(var i =0;i<COMPLEX_CONSONANTS.length;i++){//ㄱ+ㅅ=ㄳ
                        if(COMPLEX_CONSONANTS[i][0]==lastText && COMPLEX_CONSONANTS[i][1]==text){
                           text = COMPLEX_CONSONANTS[i][2];
                           $area.val(input.slice(0,-1) + text);
                             break loop;
                            }
                     }
                     //ㄱ+ㄹ=ㄱㄹ
                             $area.val(input + text);
                     
                           }else{//모음+자음
                              //ㅏ+ㄱ=ㅏㄱ
                              $area.val(input + text); 
                         }
               
               }else if(COMPLETE_JUNG.indexOf(text)>-1){ //모음
                        if(COMPLETE_CHO.indexOf(lastText)>-1){//자음+모음
                           //ㄱ+ㅏ=가
                           var lastCode= COMPLETE_CHO.indexOf(lastText);
                           var textCode= COMPLETE_JUNG.indexOf(text);
                           text = String.fromCharCode( 0xAC00 + 21*28*lastCode + 28*textCode );
                           $area.val(input.slice(0,-1) + text);
                        }else{//모음+모음
                           for(var i =0;i<COMPLEX_VOWELS.length;i++){// ㅗ+ㅏ=ㅘ
                              if(COMPLEX_VOWELS[i][0]==lastText && COMPLEX_VOWELS[i][1]==text){
                                 text = COMPLEX_VOWELS[i][2];
                                 $area.val(input.slice(0,-1) + text);
                             break loop;
                           }
                           }
                           // ㅗ+ㅡ=ㅗㅡ
                           $area.val(input + text);
                        }
               }
            }
         }else{//마지막 문자가 영어
            $area.val(input + text);
         }
      }else{//입력글자가 영어라면 바로 입력
         $area.val(input + text);
      }
      
   
      if(shiftCnt>0){
         if($j("#langu").val()=="eng"){
            change_keyboard('shiftEng',shiftEng);
         }else if($j("#langu").val()=="shiftEng"){
            change_keyboard('eng',eng);
         }else if($j("#langu").val()=="kor"){
            change_keyboard('shiftKor',shiftKor);
         }else if($j("#langu").val()=="shiftKor"){
            change_keyboard('kor',kor);
         }
         
         shiftCnt=0;
      }
   }
});

