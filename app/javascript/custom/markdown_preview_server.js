
// app/javascript/markdown_preview_server.js
document.addEventListener("turbo:load", initMdPreview);
document.addEventListener("DOMContentLoaded", initMdPreview);

function initMdPreview() {
  const textarea = document.getElementById("markdown-input");
  const preview  = document.getElementById("markdown-preview");
  const tabPreviewBtn = document.getElementById("tab-preview");
  const tabInputBtn   = document.getElementById("tab-input");
  const form = document.querySelector('[data-testid="impression-form"]');

  if (!textarea || !preview || !tabPreviewBtn || !tabInputBtn || !form) return;

  const previewUrl = form.dataset.previewUrl;
  const csrfToken  = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

  const renderViaServer = async () => {
    try {
      const res = await fetch(previewUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({ body: textarea.value || "" })
      });
      if (!res.ok) throw new Error(`Preview failed: ${res.status}`);
      const json = await res.json();
      preview.innerHTML = json.html || '<span class="text-danger">プレビュー取得に失敗しました</span>';
    } catch (e) {
      console.error(e);
      preview.innerHTML = '<span class="text-danger">プレビュー取得に失敗しました</span>';
    }
  };

  // ▼ プレビュータブに切替でサーバレンダリング
  tabPreviewBtn.addEventListener("click", renderViaServer);

  // ▼ プレビュー表示中の軽いリアルタイム更新（任意）
  textarea.addEventListener("input", () => {
    const isPreviewActive = tabPreviewBtn.classList.contains("active");
    if (isPreviewActive) {
      clearTimeout(textarea._mdPreviewTimer);
      textarea._mdPreviewTimer = setTimeout(renderViaServer, 150); // デバウンス
    }
  });
}
