(defun richfitz/make-script-executable ()
  "If file starts with a shebang, make `buffer-file-name' executable"
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (when (and (looking-at "^#!")
		 (not (file-executable-p buffer-file-name)))
	(set-file-modes buffer-file-name
			(logior (file-modes buffer-file-name) #o100))
	(message (concat "Made " buffer-file-name " executable"))))))

(add-hook 'after-save-hook 'richfitz/make-script-executable)
