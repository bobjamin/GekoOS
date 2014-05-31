//Set prev and next pages
    var prev = document.getElementById('prev');
    var next = document.getElementById('next');
    var metas = document.getElementsByTagName('meta');
    var curr = 1;
    for(var i = 0;i<metas.length;i++)
    {
      if(metas[i].name == 'chapter')
      {
        curr = parseInt(metas[i].content);
      }
    }
    var prevch = curr-1;
    var nextch = curr+1;
    if(curr<=1)
      prev.href = '../index.html';
    else
      prev.href = './Chapter'+(prevch<=9?'0':'') + '' + prevch+ '.html';
    next.href = './Chapter'+(nextch<=9?'0':'')+''+nextch+'.html';

//Sort Code Syntax Highlights
var precodes = document.getElementsByClassName('nasmcode');
  for(var j = 0;j<precodes.length;j++)
  {
    var codetag = precodes[j];
    var text = codetag.innerText;
    text = text.replace(/\b(ADD|AND|CALL|CLI|CMP|HLT|INT|JC|JE|JG|JGE|JL|JLE|JMP|JNE|JZ|MOV|OR|POP|PUSH|RET|SHL|SHR|XOR)\b/ig,"<SPAN class='mnemonic'>$&</SPAN>");
    text = text.replace(/(\bE?([SB][IP]\b))|(\bE?[CDE]S\b)/ig,"<SPAN class='mnemonic'>$&</SPAN>");
    text = text.replace(/(\bBITS|\bORG|%include)\b/ig,"<SPAN class='preprocessor'>$&</SPAN>");
    
    text = text.replace(/\bE?[ABCD][XHL]\b/ig,"<SPAN class='register'>$&</SPAN>");
    text = text.replace(/(\b|\.)[A-Z]\w*\:/ig,"<SPAN class='label'>$&</SPAN>");
    text = text.replace(/\b(BYTE|WORD|DWORD|QWORD|(D[DBW]))\b/ig,"<SPAN class='sizeallocation'>$&</SPAN>");
    text = text.replace(/(\b0X[0-9A-F]+\b)|(\b\d+\b)|(\b[0-9A-F]+H\b)|(\b[01]+b\b)/ig,"<SPAN class='number'>$&</SPAN>");
    text = text.replace(/\".*\"/ig,"<SPAN class='string'>$&</SPAN>");
    text = text.replace(/;.*/ig,"<SPAN class='comment'>$&</SPAN>");

    
    codetag.innerHTML =  text;
    var spantags = codetag.getElementsByTagName('SPAN');
    for(var i = 0;i<spantags.length;i++)
    {
      var span = spantags[i];
      span.innerHTML = span.innerText;
    }
  }
  precodes = document.getElementsByClassName('shellscript');
  for(var j = 0;j<precodes.length;j++)
  {
    var codetag = precodes[j];
    var text = codetag.innerText;
   text = text.replace(/(\@?ECHO.? ?)|((ERRORLEVEL||PAUSE|START|SET|NASM|IF|GOTO|COPY) )/ig,"<SPAN class='shellcommand'>$&</SPAN>");
  text = text.replace(/\/\w\b/ig,"<SPAN class='shelloption'>$&</SPAN>");
  text = text.replace(/-\w\b/ig,"<SPAN class='shelloption'>$&</SPAN>");
  text = text.replace(/\%\w+\%/ig,"<SPAN class='shelllookup'>$&</SPAN>");
  text = text.replace(/\:\:.*/ig,"<SPAN class='shellcomment'>$&</SPAN>");
  codetag.innerHTML =  text;
    var spantags = codetag.getElementsByTagName('SPAN');
    for(var i = 0;i<spantags.length;i++)
    {
      var span = spantags[i];
      span.innerHTML = span.innerText;
    }
  }