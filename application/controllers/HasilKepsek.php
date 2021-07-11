<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HasilKepsek extends CI_Controller {

	public function __construct(){
		parent::__construct();
		if (!$this->ion_auth->logged_in()){
			redirect('auth');
		}
		
		$this->load->library(['datatables']);// Load Library Ignited-Datatables
		$this->load->model('Master_model', 'master');
		$this->load->model('Ujian_model', 'ujian');
		
		$this->user = $this->ion_auth->user()->row();
	}

	public function output_json($data, $encode = true)
	{
		if($encode) $data = json_encode($data);
		$this->output->set_content_type('application/json')->set_output($data);
	}

	public function data()
	{
		// Data Siswa, keterampilan, hasil ujian
	}

	public function NilaiMhs($id)
	{
		$this->output_json($this->ujian->HslUjianById($id, true), false);
	}

	public function index()
	{
		$data = [
			'user' => $this->user,
			'judul'	=> 'Ujian',
			'subjudul'=> 'Hasil Ujian Kepsek',
		];
		$this->load->view('_templates/dashboard/_header.php', $data);
		$this->load->view('ujian/hasil-kepsek');
		$this->load->view('_templates/dashboard/_footer.php');
	}
}