<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class JurusanKeterampilan extends CI_Controller {

	public function __construct(){
		parent::__construct();
		if (!$this->ion_auth->logged_in()){
			redirect('auth');
		}else if (!$this->ion_auth->is_admin()){
			show_error('Hanya Administrator yang diberi hak untuk mengakses halaman ini, <a href="'.base_url('dashboard').'">Kembali ke menu awal</a>', 403, 'Akses Terlarang');			
		}
		$this->load->library(['datatables', 'form_validation']);// Load Library Ignited-Datatables
		$this->load->model('Master_model', 'master');
		$this->form_validation->set_error_delimiters('','');
	}

	public function output_json($data, $encode = true)
	{
        if($encode) $data = json_encode($data);
        $this->output->set_content_type('application/json')->set_output($data);
    }

    public function index()
	{
		$data = [
			'user' => $this->ion_auth->user()->row(),
			'judul'	=> 'Jurusan Keterampilan',
			'subjudul'=> 'Data Jurusan Keterampilan'
		];
		$this->load->view('_templates/dashboard/_header.php', $data);
		$this->load->view('relasi/jurusanketerampilan/data');
		$this->load->view('_templates/dashboard/_footer.php');
    }

    public function data()
    {
        $this->output_json($this->master->getJurusanKeterampilan(), false);
	}

	public function getJurusanId($id)
	{
		$this->output_json($this->master->getAllJurusan($id));		
	}
	
	public function add()
	{
		$data = [
			'user' 		=> $this->ion_auth->user()->row(),
			'judul'		=> 'Tambah Jurusan Keterampilan',
			'subjudul'	=> '',
			'keterampilan'	=> $this->master->getKeterampilan()
		];
		$this->load->view('_templates/dashboard/_header.php', $data);
		$this->load->view('relasi/jurusanketerampilan/add');
		$this->load->view('_templates/dashboard/_footer.php');
	}

	public function edit($id)
	{
		$data = [
			'user' 			=> $this->ion_auth->user()->row(),
			'judul'			=> 'Edit Jurusan Keterampilan',
			'subjudul'		=> '',
			'keterampilan'		=> $this->master->getKeterampilanById($id, true),
			'id_keterampilan'		=> $id,
			'all_jurusan'	=> $this->master->getAllJurusan(),
			'jurusan'		=> $this->master->getJurusanByIdKeterampilan($id)
		];
		$this->load->view('_templates/dashboard/_header.php', $data);
		$this->load->view('relasi/jurusanketerampilan/edit');
		$this->load->view('_templates/dashboard/_footer.php');
	}

	public function save()
	{
		$method = $this->input->post('method', true);
		$this->form_validation->set_rules('keterampilan_id', 'Mata Kuliah', 'required');
		$this->form_validation->set_rules('jurusan_id[]', 'Jurusan', 'required');
	
		if($this->form_validation->run() == FALSE){
			$data = [
				'status'	=> false,
				'errors'	=> [
					'keterampilan_id' => form_error('keterampilan_id'),
					'jurusan_id[]' => form_error('jurusan_id[]'),
				]
			];
			$this->output_json($data);
		}else{
			$keterampilan_id 	= $this->input->post('keterampilan_id', true);
			$jurusan_id = $this->input->post('jurusan_id', true);
			$input = [];
			foreach ($jurusan_id as $key => $val) {
				$input[] = [
					'keterampilan_id' 	=> $keterampilan_id,
					'jurusan_id'  	=> $val
				];
			}
			if($method==='add'){
				$action = $this->master->create('jurusan_keterampilan', $input, true);
			}else if($method==='edit'){
				$id = $this->input->post('keterampilan_id', true);
				$this->master->delete('jurusan_keterampilan', $id, 'keterampilan_id');
				$action = $this->master->create('jurusan_keterampilan', $input, true);
			}
			$data['status'] = $action ? TRUE : FALSE ;
		}
		$this->output_json($data);
	}

	public function delete()
    {
        $chk = $this->input->post('checked', true);
        if(!$chk){
            $this->output_json(['status'=>false]);
        }else{
            if($this->master->delete('jurusan_keterampilan', $chk, 'keterampilan_id')){
                $this->output_json(['status'=>true, 'total'=>count($chk)]);
            }
        }
	}
}