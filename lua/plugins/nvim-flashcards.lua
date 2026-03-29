return {
    "yo-reign/nvim-flashcards",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("flashcards").setup({
            directories = { "~/notes/flashcards/" },
            storage = "json",
            db_path = "~/notes/assets/",
            fsrs = {
                target_correctness = 0.85,
            },
        })

        vim.keymap.set("n", "<leader>fcr", ":FlashcardsReview<CR>", { desc = "Review flashcards" })
        vim.keymap.set("n", "<leader>fcs", ":FlashcardsScan<CR>", { desc = "Scan for new flashcards" })
        vim.keymap.set("n", "<leader>fcb", ":FlashcardsBrowse<CR>", { desc = "Browse flashcards" })
        vim.keymap.set("n", "<leader>fct", ":FlashcardsTags<CR>", { desc = "Browse flashcard tags" })
        vim.keymap.set("n", "<leader>fcd", ":FlashcardsDue<CR>", { desc = "Browse due flashcards" })
        vim.keymap.set("n", "<leader>fcS", ":FlashcardsStats<CR>", { desc = "Show flashcard stats" })
        vim.keymap.set("n", "<leader>fco", ":FlashcardsOrphans<CR>", { desc = "Manage orphaned cards" })
    end,
}
