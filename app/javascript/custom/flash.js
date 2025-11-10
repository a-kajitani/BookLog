
document.addEventListener("turbo:load", () => {
  //3秒後にメッセージを非表示にする
  setTimeout(() => {
      document.querySelectorAll('.flash').forEach(el => {
        el.style.display = 'none';
      });
    }, 3000);

  // // ブラウザバックでキャッシュされたページが表示されたときに削除
  // window.addEventListener('pageshow', function(event) {
  //   if (event.persisted) {
  //     document.querySelectorAll('.flash').forEach(el => el.remove());
  //   }
  // });
});
